set -gx SUBSCRIPTION_ID "377758e9-c4a1-44d2-b701-fc556632fd3c"

# Note: terraform.sh is a bash script. Convert it to a .fish file, or
# use the bass plugin: bass source ~/.azure/terraform.sh
set azprefs "$HOME/.azure/terraform.fish"
if test -f "$azprefs"
    source "$azprefs"
end
