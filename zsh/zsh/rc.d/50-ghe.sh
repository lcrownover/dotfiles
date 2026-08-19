#!/bin/bash
#
ghe() {
    my_commands=(
        "gh repo create"
        "gh repo clone"
        "gh run watch"
        "gh run view --log"
    )
    selected=$(printf '%s\n' "${my_commands[@]}" | fzf --height=40% --reverse)
    eval "$selected"
}

ghe_repo_sub_claim() {
    remote="$(git remote get-url origin)" || return
    s="${remote#*:}" || return # uo-core-infrastructure/puppet-eyaml-app.git
    s="${s%.git}" || return    # uo-core-infrastructure/puppet-eyaml-app
    org="${s%%/*}" || return   # everything before the first '/'
    repo="${s##*/}" || return  # everything after the last '/'
    org_id="$(gh api "repos/$org/$repo" --jq '.owner.id')" || return
    repo_id="$(gh api "repos/$org/$repo" --jq '.id')" || return
    printf "repo:%s@%s/%s@%s:ref:refs/heads/main\n" "$org" "$org_id" "$repo" "$repo_id" || return
}
