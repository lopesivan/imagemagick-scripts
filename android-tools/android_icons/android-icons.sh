#!/bin/bash
# ----------------------------------------------------------------------------
__debug__=0; __help__=0
__usage__=0
__clean__=0
# ----------------------------------------------------------------------------
[ "$1" = '--gui'   ] && { __gui__=1; shift;   }
[ "$1" = '-h'      ] && { __help__=1; shift;  }
[ "$1" = '--help'  ] && { __help__=1; shift;  }
[ "$1" = '-d'      ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--debug' ] && { __debug__=1; ECHO=echo;shift; }
[ "$1" = '--usage' ] && { __usage__=1; shift; }
[ "$1" = '--clean' ] && { __clean__=1; shift; }
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

# vi:set nu nowrap:

# $Id:$
# AppTech’s LiveCam technology.
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#        Site: http://www.apptechcorp.com
#       Phone: +1 561 801 7985
#    Language: Shell Script
#        File: mkimage1.sh
#        Date: Sun 01 Apr 2012 08:01:31 PM BRT
# Description:
#
#

createImage()
{
	W=$1
	H=$W
	newImage=$2
	COLOR=red
	COLOR=purple

	convert -depth 32 -size ${W}x${H} \
		xc:$COLOR -colorspace RGB     \
		$newImage
}

insertGridInImage()
{
 	input=$1; output=$2
	imagick.grid.sh $input $output
}

insertTextInImage()
{
	input=$1
	output=$2
	width=`identify -format %w $input`;             \
		convert -background '#0008'                 \
		-fill white                                 \
		-gravity center                             \
		-size ${width}x${3}                         \
		caption:"${width}x${width}"                 \
		$input                                      \
		+swap -gravity south -composite             \
		$output
}

sizes=(
96
72
48
36)

#sizes=(
#36)

# ----------------------------------------------------------------------------
for s in ${sizes[*]}; do

	d=size_${s}x${s}
	test ! -d $d || rm -rf $d
	mkdir $d

	output=example.png
	createImage $s ${d}/${output}

#    input=$output
#    output=withGrid_${input}
#    insertGridInImage ${d}/${input} ${d}/${output}

	input=$output
	output=icon.png
	insertTextInImage ${d}/${input} ${d}/${output} $((s/2))

	rm ${d}/example.png

done

find . -name \*.png | xargs eog

# ----------------------------------------------------------------------------
exit 0
