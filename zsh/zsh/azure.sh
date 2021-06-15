# Set azure environment variables
AZPREFS="~/.azure/terraform.sh"
if [ -f $AZPREFS ]; then
	source $AZPREFS
fi
