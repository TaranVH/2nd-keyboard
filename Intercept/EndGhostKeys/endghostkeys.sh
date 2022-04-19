#!/bin/bash

# Injecting lines into variables and deleting them from the input file
line1D=`head -n 1 keys.ini` && line1U=`head -n 1 keys.ini` && sed -i '1d' keys.ini
line2D=`head -n 1 keys.ini` && line2U=`head -n 1 keys.ini` && sed -i '1d' keys.ini
line3D=`head -n 1 keys.ini` && line3U=`head -n 1 keys.ini` && sed -i '1d' keys.ini
line4D=`head -n 1 keys.ini` && line4U="combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3" && sed -i '1d' keys.ini

# Modifying the names of the 2 macros using the original name (adding _D and _U)
line1D=`sed 's/.$//' <<< $line1D` && line1D=`sed 's/$/_D]/' <<< $line1D`
line1U=`sed 's/.$//' <<< $line1U` && line1U=`sed 's/$/_U]/' <<< $line1U`

# Replacing trigger key ID with +1 on last digit for UP event macro
str=`sed -e 's/.*\(.\)$/\1/' <<< $line3U | tr -d $'\r'`
x=`sed 's/.$//' <<< $line3U`
y=`echo 1+"$str" | bc`
line3U=`echo "$x$y"`
# Creating the output file if it doesn't already exist
touch output_keys.ini
# Output each line individually
echo $line1D >> output_keys.ini
echo $line2D >> output_keys.ini
echo $line3D >> output_keys.ini
echo $line4D >> output_keys.ini
echo $line1U >> output_keys.ini
echo $line2U >> output_keys.ini
echo $line3U >> output_keys.ini
echo $line4U >> output_keys.ini
# Show last 8 lines of output file
tail -8 output_keys.ini
