#!/bin/bash
function AllRecords(){
            echo $'\n'
			echo $'========================================================================='
			column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
			echo $'=========================================================================\n'	
	        
}
function SpecificRecord(){
			echo $'\nPlease enter a search value to select record(s): '
			read value
			echo $'========================================================================='
			#awk -v pat=$value '$0~pat{print $0}' $myPath/$DBname/$TBname | cat 
			awk "/$value/" $mypath/$DBname/$TBname | cat 
			echo $'========================================================================='
}



function Query(){
	select opt in "All Records" "Specific Record"
		do
			case $REPLY in 
				1) AllRecords 
				   break  ;;
				2) SpecificRecord
				   break ;;
				*) echo "Not an Option !!" ;;
		    esac
	done
	
}

		echo "Please Enter Table Name To Select Data From: "
		read TBname
if [[ -f $mypath/$DBname/$TBname ]]
then
	echo $'\n'
        awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $mypath/$DBname/$TBname
		#-------------------------------------------------------------
		Query 
	    #-----------------------------------------------------------------------------------------
	while true
	do
		select opt in "another Query on the same Table" "another Query on onther Table" "Back To Tables Menu"
		do
			case $REPLY in 
				1) Query
				   ;;
				2)ls $mypath/$DBname  
				   . ./selectTB.sh
				   break  ;;
				3) . ./connect_db.sh
				   break;;
				*) echo "Not an Option !!" 
				    . ./connect_db.sh;;
			esac
		done
	done
		#------------------------------------------------------------------------------------------
	
else
	echo "Table doesn't exist"
	echo "Do you want to create it? [y/n]"
	read answer
	case $answer in
		y)
		. ./createTB.sh;;
		n)
		. ./connect_db.sh;;
		*)
		echo "invalid input. Redirecting to main menu.." ;
		sleep 2;
		. ./main_menu.sh;;
	esac
fi
