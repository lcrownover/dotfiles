function dsci() {
	cd $GDRIVEDIR/school/dsci102 || return
	source venv/bin/activate
	jupyter lab
}
