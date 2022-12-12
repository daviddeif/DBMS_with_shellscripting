#!/bin/bash
echo "Please Enter Database Name you want to delete :";
read DBname;
if  [[ $DBname =~ ^[a-zA-Z]+[0-9]*$ ]]
then
    if [[ -d $mypath/$DBname ]]
    then 
    read -p "Are You Sure You Want Delete $DBname (y/n)? " char
        case "$char" in 
        y|Y) rm -r $mypath/$DBname;
         echo "Database Deleted Successfully" ; 
        sleep 2 ; 
        . ./main_menu.sh;;
        N|n ) echo "no" sleep 2 ; 
        . ./main_menu.sh;;
        * ) echo "invalid input";;
        esac
    else
    echo "Sorry This Database doesn't exists";
    . ./drop_db.sh;
    fi;
else
    echo "Sorry Database Name can't contain a special charachter. !!";
    sleep 2;
    . ./main_menu.sh;
fi;
