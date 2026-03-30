# Path helpers — fish_add_path handles deduplication automatically
function insert_path
    fish_add_path --prepend $argv[1]
end

function append_path
    fish_add_path --append $argv[1]
end

