if type -q kubectl
    # Fish completions for kubectl work natively — no lazy loading needed.
    # To generate completions: kubectl completion fish | source
    alias k kubectl
end
