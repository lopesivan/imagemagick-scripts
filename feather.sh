#!/usr/bin/env bash
#
# Developed by Fred Weinhaus 11/9/2007 .......... revised 7/29/2008
#
# USAGE: feather [-d distance] infile outfile
# USAGE: feather [-h or -help]
#
# OPTIONS:
#
# -d      distance         feathering distance; distance>0; default=1
#
###
#
# NAME: FEATHER
# 
# PURPOSE: To feather (smooth) the white-to-black transition in a 
# binary mask image.
# 
# DESCRIPTION: FEATHER smoothes the white-to-black transition in 
# a binary mask image so that it can be used to composite one image 
# over another in an antialiased manner. The feathering process makes  
# a ramped grayscale transition over a short distance just inside the 
# white region at the white-to-black transition in the binary mask.
# 
# 
# OPTIONS: 
#
# -d distance ... DISTANCE specifies the distance (in pixels) over which 
# the smoothing occurs at the white-to-black transition in the binary mask. 
# Typically a value of one or two will suffice to anti-alias the rough 
# transition so that the composite formed by using the feathered mask 
# does not show the jagged edge of the overlay image on the background 
# image. The value for distance should be kept small to avoid removing 
# too much from the boundary of the overlay image. The default value is 
# distance=1.
#
# CAVEAT: No guarantee that this script will work on all platforms, 
# nor that trapping of inconsistent parameters is complete and 
# foolproof. Use At Your Own Risk. 
# 
######
#

# set default value for distance
dist=1

# set directory for temporary files
dir="."    # suggestions are dir="." or dir="/tmp"

# set up functions to report Usage and Usage with Description
PROGNAME=`type $0 | awk '{print $3}'`  # search for executable on path
PROGDIR=`dirname $PROGNAME`            # extract directory of program
PROGNAME=`basename $PROGNAME`          # base name of program
usage1() 
	{
	echo >&2 ""
	echo >&2 "$PROGNAME:" "$@"
	sed >&2 -n '/^###/q;  /^#/!q;  s/^#//;  s/^ //;  4,$p' "$PROGDIR/$PROGNAME"
	}
usage2() 
	{
	echo >&2 ""
	echo >&2 "$PROGNAME:" "$@"
	sed >&2 -n '/^######/q;  /^#/!q;  s/^#*//;  s/^ //;  4,$p' "$PROGDIR/$PROGNAME"
	}


# function to report error messages
errMsg()
	{
	echo ""
	echo $1
	echo ""
	usage1
	exit 1
	}


# function to test for minus at start of value of second part of option 1 or 2
checkMinus()
	{
	test=`echo "$1" | grep -c '^-.*$'`   # returns 1 if match; 0 otherwise
    [ $test -eq 1 ] && errMsg "$errorMsg"
	}

# test for correct number of arguments and get values
if [ $# -eq 0 ]
	then
	# help information
   echo ""
   usage2
   exit 0
elif [ $# -gt 4 ]
	then
	errMsg "--- TOO MANY ARGUMENTS WERE PROVIDED ---"
else
	while [ $# -gt 0 ]
		do
			# get parameter values
			case "$1" in
		  -h|-help)    # help information
					   echo ""
					   usage2
					   exit 0
					   ;;
				-d)    # get distance
					   shift  # to get the next parameter - opacity
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID DISTANCE SPECIFICATION ---"
					   checkMinus "$1"
					   # test width values
					   dist=`expr "$1" : '\([0-9]*\)'`
					   [ "$dist" = "" ] && errMsg "DISTANCE=$dist IS NOT A POSITIVE INTEGER NUMBER"
		   			   disttest=`echo "$dist < 1" | bc`
					   [ $disttest -eq 1 ] && errMsg "--- DISTANCE=$dist MUST BE A POSITIVE INTEGER ---"
					   ;;
 				 -)    # STDIN, end of arguments
  				 	   break
  				 	   ;;
				-*)    # any other - argument
					   errMsg "--- UNKNOWN OPTION ---"
					   ;;					   
		     	 *)    # end of arguments
					   break
					   ;;
			esac
			shift   # next option
	done
	#
	# get infile and outfile
	infile=$1
	outfile=$2
fi

# test that infile provided
[ "$infile" = "" ] && errMsg "NO INPUT FILE SPECIFIED"

# test that outfile provided
[ "$outfile" = "" ] && errMsg "NO OUTPUT FILE SPECIFIED"

tmpA="$dir/feather_$$.mpc"
tmpB="$dir/feather_$$.cache"
trap "rm -f $tmpA $tmpB; exit 0" 0
trap "rm -f $tmpA $tmpB; exit 1" 1 2 3 15

if convert -quiet -regard-warnings "$infile" +repage "$tmpA"
	then
	: ' do nothing '
else
	errMsg "--- FILE $infile DOES NOT EXIST OR IS NOT AN ORDINARY FILE, NOT READABLE OR HAS ZERO SIZE ---"
	usage
	exit 1
fi

# process image

qmax=`convert xc: -format "%[fx:quantumrange]" info:`
# blur image
# remove the blurring outside the transition and scale the blurring inside to full range
convert $tmpA -blur ${dist}x${qmax} -level 50%,100% $outfile
exit 0