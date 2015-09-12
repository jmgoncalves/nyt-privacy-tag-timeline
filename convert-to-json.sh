#!/bin/bash
# Output nodes and links in json
OIFS=$IFS
IFS=','

echo "["

# Process years
firsttag=0
while read line; do
	if [ -z "$years" ]; then
		declare -a years=($line)
	else
		declare -a tag=($line)
		if [ $firsttag -gt 0 ]; then
			echo -e ",\n{  \"articles\": ["
		else
			echo "{  \"articles\": ["
		fi
		tLen=${#years[@]}
		first=0
		for (( i=1; i<${tLen}; i++ )); do
			if [ ${tag[$i]} -gt 0 ]; then
				if [ $first -gt 0 ]; then
					echo -ne ",\n    [ ${years[$i]}, ${tag[$i]} ]"
				else
					echo -ne "    [ ${years[$i]}, ${tag[$i]} ]"
				fi
				let "first += 1"
			fi
    done
		echo -ne "\n ], \"name\": \"${tag[0]}\" }"
		let "firsttag += 1"
	fi
done < $1

echo "]"

# Restore internal field separator
IFS=$OIFS
