#!/bin/bash

mypath=$PWD/DATABASE_STORED
export mypath

PS3="Enter your input no --> "

select name in "Create Database" "List All Databases" "Connect Database" "Drop Database" "Exit"
do
    case $name in 
         "Create Database" )
         . ./create_db.sh ;;
         
         "List All Databases" )
         ls $mypath ;;
         
         "Connect Database" )
         . ./connect_db.sh ;;
         
         "Drop Database" )
         . ./drop_db.sh ;;
         
         "Exit" )
         break ;;
         
         * )
         echo "Invalid input" ;;
    esac
done
