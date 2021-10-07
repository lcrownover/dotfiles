if [ -d $HOME/GoogleDrive ]; then
	export GDRIVEDIR="GoogleDrive"
elif [ -d $HOME/Google\ Drive ]; then
	export GDRIVEDIR="Google\ Drive"
fi

alias cdgd="cd $GDRIVEDIR"
