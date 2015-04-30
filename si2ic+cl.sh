#!/bin/bash

# Script to generate the IC and the CL Codes from the SI address

# Copyright 2015  Chris Abela <kristofru@gmail.com>, Malta
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

function print_ic_cl {
  echo "$SI" | grep -q '[^0-9]' && \
    echo "SI=$SI, an integer is expected ****  ABORTING ***" && \
    return 1
  [ "$SI" -gt 63 -o "$SI" -lt 0 ] && \
    echo "SI=$SI, SI must be an integer smaller than 64 and bigger or equal to 0." && \
    return 2
  SI=$( echo "$SI" | sed 's/^0*//g' ) # Strip leading zeroes
  SI16=$(( $SI + 16 ))
  CL=$(( $SI16 / 16 ))
  IC=$(( $SI16 % 16 ))
  echo "For an SI=$SI, IC=$IC and CL=$CL"
}

# No paramters were passed
[ "$#" -eq 0 ] && \
  read -p "Enter the SI Code: " SI && \
  print_ic_cl

# One or more parameter was passed
while [ $# -gt 0 ]; do
  SI="$1" 
  print_ic_cl
  unset SI
  shift
done
