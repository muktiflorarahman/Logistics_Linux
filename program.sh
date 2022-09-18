#!/bin/bash


function menu() {
    echo "Choose one of the following options: "

    echo "1. print hello" 
    echo "2. help"
    echo "3. exit program"
}

userInput=0

while [ $userInput -ne 3 ]
do
    menu
    read userInput

done