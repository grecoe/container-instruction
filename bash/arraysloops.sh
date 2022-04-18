#!/bin/bash

# Examples on using arrays

#################################################
# Basics on creating one

# Start with a string with a separater diff than a space
RG="Compute-rg-airflowtest2602-asally"

# Update IFS to parse it
oldifs=$IFS
IFS='-'

# Read it into a variable
read -r -a RG_PARTS <<< "$RG"

# Array Length
echo "${#RG_PARTS[@]}"
# Third entry
echo ${RG_PARTS[2]}

# Loop through them
COUNTER=0
for element in "${RG_PARTS[@]}"
do
    echo "$COUNTER: $element"
    COUNTER=$[COUNTER+1]
done

# Put the parser back the way it was
IFS=$oldifs


#########################################################
# Multi line text

# Read it into a variable
read -r -d '' VAR << EOM
This is line 1.
This is line 2.
Line 3.
EOM

# Must access it with quotes to maintain newlines
echo "$VAR"


#########################################################
# Loops

# Get containernameX for 1-3 
for l in containername{1..3}
do 
    echo $l
done

# Standard for loop 
START=1
ITERATIONS=10
for ((i=$START ; i<=$ITERATIONS; i++))
do
   echo "i: $i"
done