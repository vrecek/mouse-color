# Characters array
CHAR_ARRAY=(0 1 2 3 4 5 6 7 8 9 "A" "B" "C" "D" "E" "F")


# Sets color to $1 argument
set_color () {
	rivalcfg  --z1 $1 --z2 $1 --z3 $1 --z4 $1


	if [ "$1" = "#000000" ]; then
		echo "Illumination turned off"
	else
		echo "Color set to: $1"
	fi


	exit 0
}


# Sets random color
set_random_color () {
	local RANDOM_COLOR=""


	for i in {1..6}
	do
		RANDOM_CHAR=$(( $RANDOM % ${#CHAR_ARRAY[*]} ))
		RANDOM_COLOR="${RANDOM_COLOR}${CHAR_ARRAY[$RANDOM_CHAR]}"
	done


	if [ -z "$1" ]; then
		set_color "#${RANDOM_COLOR}"
	else
		echo $RANDOM_COLOR
	fi
}


# Random colors on every side
set_every_side () {
	CFG=""

	for i in {1..4}
	do
		NEW_COLOR=$(set_random_color 1)
		CFG="${CFG} --z${i} #${NEW_COLOR}"
	done

	rivalcfg $CFG

	exit 0
}


# Prints error
print_error () {
	echo "Incorrect option"
	echo "-- Available options: --"
	echo
	echo "-c <color> (Sets color)"
	echo "-o (Turns of the illumination)"
	echo "-r (Random color)"
	echo "-a (Random color for every side)"

	exit 1
}


# Set color based on a argument
while getopts ":c:aor" o; do
	case ${o} in
		o)
			set_color "#000000"
			;;

		c)
			set_color $OPTARG
			;;


		r)
			set_random_color
			;;


		a)
			set_every_side
			;;

		*)
			print_error
			;;
	esac
done


# If no args were passed, display error
print_error
