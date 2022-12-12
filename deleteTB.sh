#!/bin/bash
function DeleteRecord(){
	echo "Please Enter number of field To Find Value: "
	read field
	num='^[0-9]+$'
	x=`grep 'PK' $mypath/$DBname/$TBname | wc -w`
if [[ $field =~ $num ]] && [ $field -le $x  ]
then 
	echo $'\n'
	echo "$TBname Before Delete"
					echo $'========================================================================='
					column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
	echo "Please Enter Field Value To Delete Record(s): "
	read value
	echo $'\n'
	exist=`grep -E "$value" $mypath/$DBname/$TBname | wc -l `
	if ! [ exist -eq 0]
	#if cut -f$field -d" " $mypath/$DBname/$TBname | grep -w -q ${value}
	then
		sed -i "/$value/d" $mypath/$DBname/$TBname
		echo $'Record(s) deleted successfully!\n'
		            echo "$TBname After Delete"
					echo $'========================================================================='
					column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
	else
		echo $'No such entry in that column\n'
		. ./deleteTB.sh
	fi
else echo "Field number should be integer value and less than number of feilds "
     . ./deleteTB.sh
fi 
}

function DeleteAllRecords(){
	echo "$TBname Before Delete"
					echo $'========================================================================='
					column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
	
		sed -i '2,$ d' $mypath/$DBname/$TBname
	echo $'Record(s) deleted successfully!\n'
		            echo "$TBname After Delete"
					echo $'========================================================================='
					column -t -s ' '   $mypath/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	

}
echo "Please Enter Table Name To Delete From: "
read TBname
if [[ -f $mypath/$DBname/$TBname ]]
then
	echo $'\n'
	awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $mypath/$DBname/$TBname
	echo $'\n'
	
	select opt in "Delete specific Record" "Delete all Records"
		do
			case $REPLY in 
				1) DeleteRecord 
				   sleep 2
				   clear 
				   sleep 2
				   . ./connect_db.sh
				   ;;
				2)  DeleteAllRecords
				 sleep 2
				   clear 
				   sleep 2
				   . ./connect_db.sh
				   ;;
				*) echo "Not an Option !!" 
				sleep 2
				   clear 
				   sleep 2
				   . ./deleteTB.sh
				   ;;
			esac
		done

else
	echo "Table doesn't exist"
	echo "Do you want to create it? [Y/N]"
	read answer
	case $answer in
		y)
		 . ./createTB.sh ;;
		n)
		. ./deleteTB.sh ;;
		*)
		echo "Not an Option Back to main menu.." ;
		sleep 2;
		. ./main_menu.sh;;			
	esac
	fi
