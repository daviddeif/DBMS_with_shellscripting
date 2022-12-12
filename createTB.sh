#!/bin/bash

echo "Please Enter Table Name :";
read TBname;
if  [[ $TBname =~ ^[a-zA-Z]+[0-9]*$ ]]
then
    if [ -f $mypath/$DBname/$TBname ]
    then 
    echo "Sorry Table Name is Already Exists";
    sleep 2;
    . ./createTB.sh;
    else
    touch $mypath/$DBname/$TBname;
    echo "Table Created Successfully";
            sleep 2;
        echo "Please Enter Number Of Columns:";
        read num;
        if [[ $num =~ ^[0-9]+$ ]] && [ $num -ge 2 ]
        then
            pk_taken=0;
                for((i=1 ; i<=$num ; i++))
                do
                    echo "Enter Name Of Column No.$i";
                    read colname;           
                    while [ $pk_taken -eq 0 ]
                    do
                        echo "Do you Want This Column To Be PRIMARY KEY(y/n)?";
                        read pk;
                        if [[ $pk == "Y" || $pk == "y" ]]
                        then
                            pk_taken=1;
                            echo -n "#PK:" >> $mypath/$DBname/$TBname;
                        else
                            break;
                        fi
                    done
                    echo "Please Choose Datatype For Column {int | string} ?"
                       read dataType;
                            case $dataType in 
                                "int") 
                                echo -n $colname":$dataType: " >> $mypath/$DBname/$TBname ;;
                                "string")  
                                echo -n $colname":$dataType: " >> $mypath/$DBname/$TBname ;;
                                *) 
                                echo "Not an Option !!";
                                ((i = $i - 1));;
                            esac
                       
                done ;
                echo "Your Table Create Successfully ";
                sleep 2;
                clear;
                . ./connect_db.sh;
        else
            echo "Sorry You Must Enter Number of Columns and to be greater than 1 !!";
                sleep 2;
                . ./createTB.sh;
        fi;
    fi;
else
    echo "Sorry Table Name can't Contain a Special Character( ! @ # ^ & * # )";
    sleep 2;
    . ./createTB.sh;
fi;





