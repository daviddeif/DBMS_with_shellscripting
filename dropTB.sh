#!/bin/bash 
echo "All Tables For $DBname"
sleep 2
ls $mypath/$DBname
echo "======================================================="
echo "Please Enter name of table You Want to Delete:"
read TBname
if [ -f  $mypath/$DBname/$TBname ]
then
    echo "Are you sure you want to delete $TBname [y/n]"
    read answer
            case $answer in 
            y|Y) 
                rm $mypath/$DBname/$TBname
                echo "$TBname Deleted Successfully.."
                echo "Remaining Tables For $DBname"
                echo "======================================================="
                sleep 1
                ls   $mypath/$DBname
               
                sleep 2
                . ./connect_db.sh
                ;;
            n|N) 
                break
                ;;
            *) echo "sorry invalid input " ;;
            esac
            
else
    echo "$TBname Doesn't exist!"
fi
