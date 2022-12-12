#!/bin/bash
clear
. ./ValidationsFunction.sh
echo "Available Tables Are... " 
ls $mypath/$DBname
echo "Please Enter Table Name To Insert Data Into : "
read TBname
if [[ -f $mypath/$DBname/$TBname ]] 
	then
	x=`grep 'PK' $mypath/$DBname/$TBname | wc -w` #get number of feilds that each word separated by space
	column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
	echo -e  >> $mypath/$DBname/$TBname
	for((i=1;    i <= x;     i++)) 
	do      
	colName=`grep PK $mypath/$DBname/$TBname | cut -f$i -d" "`
	echo $"Please  Enter Data For Column NO.$i [$colName]"
	read data 
#function to check type of data 
	checkDataType $i $data
	if [[ $? != 0 ]]
	 then
	  (( i = $i - 1 ))
	else	
	  echo -n $data" " >> $mypath/$DBname/$TBname
					
	fi
	done	
   echo "Insert Done To $TBname"
   column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
   sleep 1
   echo "Do You Want To Insert More Records into a table ? [y/n]"
					read answer
					case $answer in
						y)
						. ./insertTB.sh;;
						n) echo "Back To Table Menu"
						. ./connect_db.sh;;
						*)
						echo "sorry, invalid input backing to main menu... " ;
						sleep 2;

						. ./main_menu.sh;;
						esac	
else
   echo "Table Doesn't Exist"
   echo "Do You Want To Create it? [y/n]"
		read answer
		case $answer in
			y)
			. ./createTB.sh;;
			n)
			. ./insertTB.sh;;
			*)
			echo "sorry, invalid input backing to main menu... " ;
			sleep 2;
		
			. ./main_menu.sh;;	
		esac
        
fi ;
