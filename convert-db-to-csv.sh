#!/bin/bash

#########################################################################
# 
# Author: Darren Tu  github.com/darrentu
# Please read README before running the program
# 
#########################################################################


if [ "$1" = "" ]
then
	echo "You must enter the name of the database. Please check the README."
	exit 1
fi

if [ "$2" == "" ]
then
	echo "You must enter a valid destination path for the .csv files"
	exit 2
fi

db=$1
loc=$2

t=($(sqlite3 $db ".tables"))

# For each table in the database
for i in "${t[@]}"
do
	sqlite3 $db<<- EXIT_HERE
	.mode csv
	.headers on
	.output '$loc/$i.csv'
	SELECT * FROM $i;
	.exit
	EXIT_HERE
  echo "$i.csv generated"
done