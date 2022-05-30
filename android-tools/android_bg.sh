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
	H=$2
	newImage=$3
	COLOR=red
	COLOR='#DEB887'
	convert -depth 32 -size ${W}x${H} \
		xc:"$COLOR" -colorspace RGB     \
		$newImage
}

insertGridInImage()
{
 	input=$1; output=$2
	imagemagick-grid $input $output
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
		caption:"-- background --"                  \
		$input                                      \
		+swap -gravity south -composite             \
		$output
}

# HD
# 16:9
W=1280
H=800

output=example.png
createImage $W $H ${output}

input=$output
output=withGrid${input}
insertGridInImage ${input} ${output}

input=$output
output=bg.png
insertTextInImage ${input} ${output} $((H))

rm example.png withGridexample.png

# ----------------------------------------------------------------------------
exit 0
