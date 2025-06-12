# These come mostly from the internet

# Basic concept by @kspatlas on discord
# https://discord.com/channels/601130461678272522/615253963645911060/1272315085708328960
def xkcd [number = ""] {
  let xkcd = (http get $"https://xkcd.com/($number)/info.0.json" | reject news link)
  let display = {
      date: $"($xkcd.day)-($xkcd.month)-($xkcd.year)"
      title: $xkcd.title
      ...($xkcd | reject day month year safe_title title)
  }
  print $display
  http get $xkcd.img | kitty icat --align left
}

# By @maxim on discord
# https://discord.com/channels/601130461678272522/615253963645911060/1242478946587508797
use std iter scan

def format-nu [
] {
    let $input = default (
        history | last 2 | first | get command
    )

    let pipe = char --integer 2000

    let closures = $input | str replace --all ' | ' $pipe

    let chars = $closures
        | split chars --grapheme-clusters

    $chars
    | each {|i|
        {'(': 1 '{': 1 ')': -1 '}': -1}
        | get -i $i
        | default 0
    }
    | scan 0 {|i acc| [($acc + $i) 0] | math max } --noinit
    | wrap level
    | merge ($chars | wrap chars)
    | update chars {|i|
        if $i.chars == $pipe {
            seq 1 $i.level | each {'    '} | str join | $"\n($in)| "
        } else {
            $i.chars
        }
    }
    | get chars
    | str join
    | commandline edit -r $in
}

def package-locate [package:string] {
    try {
        print $"Trying to locate package: ($package)"
        let options = (
            nix-locate --no-group --type x --type s --top-level --whole-name --minimal $"bin/($package)"
            | parse -r "^(.*?)(?=.out$)"
            | get capture0
            | to text
        )
        if ($options | is-empty) {
            print $"($package) not found"
            return null
        }
        let option = ($options | gum choose --header="Choose to Run:")
        print $"Creating a nix shell out of package ($option)"
        nix-shell --command nu -p $option
    }
}

def shellify [...package:string] {
    try {
        print $"Creating a nix shell out of ($package)"
        nix-shell --command nu -p ...$package
    }
}

def bathelp [
    command:string # command whose help is to be shown
] {
    if ($command | is-not-empty) {
        run-external $command "--help" | bat --plain --language=help
    }
}

def yt [
    url:string # url of the youtube video
    --audio(-a) # get the audio
    --transcript(-t) # get the transcript
    --output(-o):string # output file name (don't provide file extension)
    --clean(-c) # clenup the transcript to just have the text
] {
    mut args = ["--quiet", "--no-warnings", "--progress", "--sponsorblock-remove", "sponsor"]
    if $audio {
        $args = ($args | append ["-x", "--audio-quality", "0", "-S", "ext"])
    }
    if $transcript {
        $args = ($args | append ["--write-subs", "--write-auto-sub", "--sub-lang", "en", "--sub-format", "ttml", "--convert-subs", "srt"])
    }

    if $transcript and not $audio {
        $args = ($args | append ["--skip-download"])
    }

    mut stream = false
    if ($output | is-not-empty) {
        if (($output  == "-") and $transcript) {
            $stream = true
            $args = ($args | append ["-o", "output-stream-temp"])
        } else {
            $args = ($args | append ["-o", $output])
        }
    }

    yt-dlp ...$args $url

    def cleanTranscript [fileName:string] {
        let file = ls | where name == $"($fileName).en.srt" | get name | to text
        open $file | lines | where ($it != "" and $it !~ "^\\d+") | parse -r "<font[^>]*>(.*?)<\\/font>" | where ( $it.capture0 != "[Music]") | get capture0 | save -f $"($fileName).txt"
        rm $file
    }

    if $clean and $transcript {
        if ($output | is-not-empty) {
          if ($output  == "-") {
            cleanTranscript ("output-stream-temp")
          } else {
            cleanTranscript ($output)
          }
        }
        # TODO: handle when user doesn't provide output file name
    }

    if $stream {
        let file = ls | where name =~ "output-stream-temp*" | get name | to text
        let $outputText = (open $file)
        rm $file
        return $outputText
    }
}

def modgen [] {
    let roles = (genmodroles | from yml | insert default [])

    mut mods = (cat ~/.config/mods/mods.yml | from yml | reject roles)

    $mods = ($mods  | insert roles $roles)

    $mods | to yaml | save -f ~/.config/mods/mods.yml
}

def getresponse [
    hash?:string # hash of the mods conversation to get response from
    --showlast(-S) # Show the last saved conversation.
] {
    mut text = ""
    if $showlast {
        $text = (mods -S)
    } else {
        $text = (mods -s $hash)
    }
    mut response = ($text | lines | to text | grep -A 9999999 Assistant | str trim | lines)

    $response.0 = ($response.0 | split column "**Assistant**: " | get column2.0)
    return ($response | to text)
}
