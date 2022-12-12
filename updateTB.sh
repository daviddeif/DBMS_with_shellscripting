#!/bin/bash
. ./ValidationsFunction.sh
echo "Please enter table name to update data: "
read TBname
if [[ -f $mypath/$DBname/$TBname ]]
then
	echo $'\n'
	awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $mypath/$DBname/$TBname
	echo $'\n'
	echo "Please enter field number to update: "
	read fieldnum
	fields=`awk '{print NF}' $mypath/$DBname/$TBname | head -1`  #get number of columns
	        if [[ $fieldnum -gt $fields || $fieldnum -lt 1 ]]
	        then
		echo "Incorrect field number. Redirecting.."
		sleep 2
		 . ./updateTB.sh
	        else
		echo $'\n'
		echo "$TBname Before Update"
	        echo '\n'
		sleep 2	
		column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
		echo '\n'
		sleep 2	
		echo "Please enter the old value: "
		read old
		echo ""
		if grep "${old}" $mypath/$DBname/$TBname  >> /dev/null
		then
			echo "Please enter new value: "
			read new
			checkDataType $fieldnum $new
			if [[ $? != 0 ]]
			then
			echo "Incorrect data type entry, Redirecting.."
			sleep 2
			. ./updateTB.sh
			else	
			awk -v oldval=$old -v newval=$new -v colnum=$fieldnum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $mypath/$DBname/$TBname
			echo $'Record(s) updated successfully!'
			echo $'\n'
			echo "$TBname After Update...."
			echo $'========================================================================='
			column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
			sleep 2	
                        echo "Do you want to update more records ? [Y/N]"
						read answer
						case $answer in
							Y|y)
                                                           sleep 2
							. ./updateTB.sh;;
							
							N|n)
							   sleep 2
							   clear 
							   echo "Back to connect to database"
							. ./connect_db.sh ;;
							
							*)echo "Not a Valid Option " 
				                        . ./main_menu.sh ;;				
						esac
			fi
		else
			echo $'No such value in the table!'
			. ./updateTB.sh
		 fi
	    fi
else
	echo "Table doesn't exist"
	echo "Do you want to create it? [y/n]"
	read answer
	case $answer in
		y)
		  . ./createTB.sh;;
		n)
		. ./updateTB.sh;;
		*)
		echo "invalid input . Redirecting to main menu.." ;
		sleep 2;
	        . ./main_menu.sh;;			
	esac
fi ;

