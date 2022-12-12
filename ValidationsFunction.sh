#!/bin/bash
#Check DateType
function checkDataType() {
datatype=`grep PK $mypath/$DBname/$TBname | cut -f$1 -d" "` 
#print first feild  

if [[ "$datatype" == *"int"* ]]
then
	if ! [[ $2 =~ ^[0-9]+$ ]]
	then
		echo "Please Enter Numbers Only !!"
		return 1
	else
		checkPK $1 $2
	fi
elif [[ "$datatype" == *"string"* ]] 
#match if type string exist in datatype variable 
then
	if ! [[ $2 =~ ^[a-zA-Z]+$ ]]
	then
		echo "Invalid input: Not a valid string!"
		return 1
	else
		checkPK $1 $2
	fi
fi
}

#Check Primary Key function
function checkPK() {
header=`grep PK $mypath/$DBname/$TBname | cut -f$1 -d" "` 
#return all feild that containing primary key
if [[ "$header" == *"PK"* ]]
then 
	if [[ `cut -f$1 -d" " $mypath/$DBname/$TBname | grep -w $2` ]]
	then
		echo $'\nPrimary Key already exists. no duplicates allowed!' 
		return 1
	fi
fi
}

