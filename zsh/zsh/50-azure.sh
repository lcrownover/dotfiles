export SUBSCRIPTION_ID="377758e9-c4a1-44d2-b701-fc556632fd3c"
# Set azure environment variables
AZPREFS="$HOME/.azure/terraform.sh"

if [ -f "$AZPREFS" ]; then
	source "$AZPREFS"
fi
