#!/bin/bash

#########################################################################
# 
# Author: Darren Tu  github.com/darrentu
# Please read README before running the program
# 
#########################################################################


if [ "$1" == "" ]; then
	echo "You must enter the name of the database. Please check the README."
	exit 1
fi

if [ "$2" == "" ]; then
	echo "You must enter a valid destination path for the .csv files"
	exit 2
fi

db=$1
loc=$2

t=($(sqlite3 $db ".tables"))

# i is the table, t is the list of tables in the database
# For each table in the database
for i in "${t[@]}"
do
	# If there is a 3rd argument, it will export only a single file
	if [ "$3" != "" ]; then
		if [ "$3" == "$i" ]; then
			sqlite3 $db<<- EXIT_HERE
			.mode csv
			.headers on
			.output '$loc/$i.csv'
			SELECT * FROM $i;
			.exit
			EXIT_HERE
	  		echo "$i.csv generated"
	  		break
	  	fi
	# exports all database tables if there is no 3rd argument
	else

		sqlite3 $db<<- EXIT_HERE
		.mode csv
		.headers on
		.output '$loc/$i.csv'
		SELECT * FROM $i;
		.exit
		EXIT_HERE
  		echo "$i.csv generated"
  	fi
done