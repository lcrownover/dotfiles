function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

function last_history_token
    echo $history[1] | read -at tokens
    echo $tokens[-1]
end
abbr -a '!$' --position anywhere --function last_history_token
