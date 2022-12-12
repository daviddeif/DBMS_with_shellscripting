#!/bin/bash

ls $mypath
echo "Please Enter Database Name To Connect It :"
read DBname
if  [[ $DBname =~ ^[a-zA-Z]+[0-9]*$ ]]
then
    if [[ -d $mypath/$DBname ]]
    then 
    echo " Successfully Connected To ($DBname)" ;
	select option in "Create Table" "List All Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back to Menu" 
	do
		case $REPLY in 
		1) . ./createTB.sh;;
		2)ls $mypath/$DBname ;;
		3) . ./dropTB.sh;;
		4) . ./insertTB.sh;;
		5) . ./selectTB.sh;;
		6) . ./deleteTB.sh;;
		7) . ./updateTB.sh;;
		8) . ./main_menu.sh;;
		*) echo "invalid input!!";;
		esac
	done
    else 
	echo "Data Base ($DBname) doesn't exist "
	echo $'\nDo You Want Create It ? [y/n] :'
	read answer
	case $answer in
	y|Y ) . ./create_db.sh;;
	n|N ) . ./connect_db.sh;;
	* ) echo "invalid input backing to main menu..." ;
	    sleep 2 ;
	   . ./main_menu.sh;;	
        esac
   
    fi;
else
    echo "invalid input (No special characters are allowed) !";
    sleep 1;
    . ./create_db.sh;
fi;



















