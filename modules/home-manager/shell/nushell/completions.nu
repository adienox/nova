def "nu-complete fabric-patterns" [] {
     fabric -l | lines | skip 2 | str trim
}

def "nu-complete mods-roles" [] {
    mods --list-roles | parse -r "^(\\w+)" | get capture0
}

extern mods [
    --model(-m) # Default model (gpt-3.5-turbo, gpt-4, ggml-gpt4all-j...).
    --ask-model(-M) # Ask which model to use with an interactive prompt.
    --api(-a) # OpenAI compatible REST API (openai, localai).
    --http-proxy(-x) # HTTP proxy to use for API requests.
    --format(-f) # Ask for the response to be formatted as markdown unless otherwise set.
    --raw(-r) # Render output as raw text when connected to a TTY.
    --prompt(-P) # Include the prompt from the arguments and stdin, truncate stdin to specified number of lines.
    --prompt-args(-p) # Include the prompt from the arguments in the response.
    --continue(-c) # Continue from the last response or a given save title.
    --continue-last(-C) # Continue from the last response.
    --list(-l) # Lists saved conversations.
    --title(-t) # Saves the current conversation with the given title.
    --delete(-d) # Deletes a saved conversation with the given title or ID.
    --delete-older-than # Deletes all saved conversations older than the specified duration. Valid units are: ns, us, µs, μs, ms, s, m, h, d, w, mo, and y.
    --show(-s): string # Show a saved conversation with the given title or ID.
    --show-last(-S) # Show the last saved conversation.
    --quiet(-q) # Quiet mode (hide the spinner while loading and stderr messages for success).
    --help(-h) # Show help and exit.
    --version(-v) # Show version and exit.
    --max-retries # Maximum number of times to retry API calls.
    --no-limit # Turn off the client-side limit on the size of the input into the model.
    --max-tokens # Maximum number of tokens in response.
    --word-wrap # Wrap formatted output at specific width (default is 80)
    --temp # Temperature (randomness) of results, from 0.0 to 2.0.
    --stop # Up to 4 sequences where the API will stop generating further tokens.
    --topp # TopP, an alternative to temperature that narrows response, from 0.0 to 1.0.
    --fanciness # Your desired level of fanciness.
    --status-text # Text to show while generating.
    --no-cache # Disables caching of the prompt/response.
    --reset-settings # Backup your old settings file and reset everything to the defaults.
    --settings # Open settings in your $EDITOR.
    --dirs # Print the directories in which mods store its data.
    --role: string@"nu-complete mods-roles" # System role to use
    --list-roles # List the roles defined in your configuration file
    --theme # Theme to use in the forms. Valid units are: 'charm', 'catppuccin', 'dracula', and 'base16'
]

extern fabric [
    -p: string@"nu-complete fabric-patterns" # choose a pattern
    -s # stream the output
    -l # list patterns
    -U # update patterns
    -c # copy to clipboard
]

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD} | str replace "/home/nox" "~"
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

# This completer will use carapace by default
let external_completer = {|spans|
    # fixing completers for aliases
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    # specific completer for specific programs
    match $spans.0 {
        # carapace completions are incorrect for nu
        nu => $fish_completer
        # fish completes commits and branch names in a nicer way
        git => $fish_completer
        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
        external: {
            enable: true
            max_results: 20
            completer: $external_completer
        }
        use_ls_colors: true
    }
}
