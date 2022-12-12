#!/bin/bash

echo "Please Enter Database Name :";
read DBname;
if  [[ $DBname =~ ^[a-zA-Z]+[0-9]*$ ]]
then
    if [[ -d $mypath/$DBname/ ]]
    then 
    echo "Database is already exists"
    else
    mkdir $mypath/$DBname
    echo "($DBname) Database Created Successfully"
    sleep 2 ;
    read -p "Do You Want Create Tables [y\n]? " char
        case $char in 
        y|Y ) sleep 2 ; . ./createTB.sh;;
        n|N ) sleep 2 ; . ./main_menu.sh;;
        * ) echo "Not An Option !";;
    esac
    fi;
else
    echo "invalid input (No special characters are allowed) !"
    sleep 2;
    . ./create_db.sh;
fi;
