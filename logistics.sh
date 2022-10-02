#!/bin/bash

## ============================================
## Namn: Mukti Flora Rahman
## E-post: mura1600@student.miun.se
## Kurs: DT038G
## ============================================

## function handles command line arguments
## ===============================================
function readArgs() { 
    echo ${1} ${2} ${3}
    #if arg is 0 then the usage information will be shown
    if [[ ${#} == 0 ]]; then
        usage
        exit 1
    fi
    
    #if arg is 1 then we want to check if the arg is valid or not
    # checks if data file exists or not
    # if data file does not exist
    if [[ ${#} == 1 ]]; then
        if test -f "$_DATA_FILE"; then
            welcome

        elif [[ "$_DATA_FILE" == "$_HELP" ]]; then
            usage 
            exit 0 
        else    
            goodbye "$_DATA_FILE" "$_NO_FILE"
        fi
    fi

    #if arg is 2 then we want to check if a switch is given in the command prompt
    if [[ ${#} == 2 ]]; then
        if test -f "$_DATA_FILE"; then
            if [[ "$_OPTIONAL_ARG" == "-b" || "$_OPTIONAL_ARG" == "--backup" ]]; then
                createBackupFile
                exit 0
            elif [[ "$_OPTIONAL_ARG" == "-p" || "$_OPTIONAL_ARG" == "--print" ]]; then
                printSortiment
                exit 0
            elif [[ "$_OPTIONAL_ARG" == "-h" || "$_OPTIONAL_ARG" == "--help" ]]; then
                usage
                exit 0
             elif [[ "$_OPTIONAL_ARG" == "-s" || "$_OPTIONAL_ARG" == "--sort" ]]; then
                usage
                exit 1
            fi
        else 
            #2 args are given, but file does not exist
            goodbye "$_NO_FILE" 
        fi
    fi

    #if arg is 3 and valid file
    if [[ ${#} == 3 ]]; then
        if test -f "$_DATA_FILE"; then
            if [[ "$_OPTIONAL_ARG" == "-s" || "$_OPTIONAL_ARG" == "--sort" ]]; then
                case "$_SORT_ARG" in
                    "i") echo i; sortColumn 1; exit 0
                    ;;
                    "n") echo n; sortColumn 2; exit 0
                    ;;
                    "v") echo v; sortColumn 3; exit 0
                    ;;
                    "l") echo l; sortColumn 4; exit 0
                    ;;
                    "b") echo b; sortColumn 5; exit 0
                    ;;
                    "h") echo h; sortColumn 6; exit 0
                    ;;
                    *) echo -e "${_INVALID_ARG} ${_SORT_ARG}\n"; usage; exit 1
                    ;;
                esac            
            else 
                usage
            fi
        else 
            #3 args are given, but file does not exist
            goodbye "$_NO_FILE" 
        fi
    fi
}



## ===============================================
## ===============================================

function usage() {
    echo
    echo "$_USAGE"
}

## ===============================================

## function for terminating the program
## ===============================================
function goodbye() {
    #${@} - arg that is sent to the function
    echo ${@}
    echo 
    exit 0
}
## ===============================================

## function for interactive mode
## ===============================================
function welcome() {
    clear
    echo 
    echo "$_WELCOME_TEXT"
    # we are calling a menu function
    showMenu
}
## ===============================================

## function that shows menu
## ===============================================
function showMenu() {
    echo 

    # using selected variable options
    select opt in ${_MENU_OPTIONS}; 
    do 
        if [[ "$opt" == "backup" ]]; then
            createBackupFile
            waitForUser
            welcome
        elif [[ "$opt" == "print" ]]; then
            printSortiment
            waitForUser
            welcome
        elif [[ "$opt" == "sort" ]]; then
            showSortMenu
            waitForUser
        elif [[ "$opt" == "help" ]]; then
            usage
            waitForUser
            welcome
        elif [[ "$opt" == "exit" ]]; then
            exit 0
        else 
            echo 
            echo ${_INVALID_OPTION};
        fi

    done

}
## ===============================================

##function for user input
## ===============================================
function waitForUser() {
    echo
    echo ${_PRESS_KEY}
    echo
    #waiting for user input
    read -n 1 -s
}
## ===============================================

##function that shows sort menu
## ===============================================
function showSortMenu() {
    clear
    echo
    echo "$_SORTING_MENU"
    echo
    
    select sort in ${_SORTING_OPTIONS}; 
    do
        if [[ "$sort" == "id" ]]; then
            sortColumn 1
            waitForUser
            showSortMenu
        elif [[ "$sort" == "name" ]]; then
            sortColumn 2
            waitForUser
            showSortMenu
        elif [[ "$sort" == "weight" ]]; then
            sortColumn 3
            waitForUser
            showSortMenu
        elif [[ "$sort" == "length" ]]; then
            sortColumn 4
            waitForUser
            showSortMenu
        elif [[ "$sort" == "width" ]]; then
            sortColumn 5
            waitForUser
            showSortMenu
        elif [[ "$sort" == "height" ]]; then
            sortColumn 6
            waitForUser
            showSortMenu
        elif [[ "$sort" == "help" ]]; then
            echo "$_SORTING_MENU"
            waitForUser
            showSortMenu
        elif [[ "$sort" == "main" ]]; then
            welcome
        else 
            echo "$_INVALID_OPTION"
            waitForUser
            showSortMenu
        fi
    done 
}
## ===============================================

##function for backup
## ===============================================
function createBackupFile() {
    echo "Creating a backup file: ${_DATA_FILE}${_BACKUP_SUFFIX}"
    cat "$_DATA_FILE" > "$_DATA_FILE""$_BACKUP_SUFFIX"

}
## ===============================================
##function that prints sortiment.txt
## ===============================================
function printSortiment() {
    echo "Printing file: ${_DATA_FILE} on screen"
    cat "$_DATA_FILE"

}
## ===============================================
##function that sorts columns
## ===============================================
function sortColumn() {
    #prints out the first line
    head -1 "$_DATA_FILE"
    #checks if it's column 2
    #it then sorts on alphabets
    #otherwise it sorts numerical
    if [[ ${1} == 2 ]]; then
        tail -n +2 "$_DATA_FILE" | sort -t$'\t' -k"$1"
    else
        tail -n +2 "$_DATA_FILE" | sort -t$'\t' -k"$1" -n
    fi

}
## ===============================================


## main program starts here
## ===============================================
clear

## creating variables
_DATA_FILE=${1} 
_OPTIONAL_ARG=${2}
_SORT_ARG=${3}
_NO_ARGS="first argument must be the data file"
_NO_FILE="file ${file1} does not exist"
_START_AGAIN="Please try to start the program again."
_USAGE="Usage : logistics FILE [ - b | - p | - s { i | n | v | l | b | h }]
Used for logistics management with FILE as underlying data.
    -b      generate backup copy of data contents and exit
    -p      print data contents and exit
    -s      sort by additional argument : id ( i ) ,
            name ( n ) , weight ( v ) , length ( l )
            width ( b ) , height ( h ) , print data contents and exit
    --help  display this help and exit"

_HELP="--help"
_INVALID_ARG="Invalid argument"
_BACKUP_SUFFIX=".backup"
_SORTING_MENU="     Help text for sorting
    =====================

    Here you can choose how to get the output sorted.
    You can sort among many different characteristics.

    Sort and print the content in the data file:
    i  -  according to product number
    n  -  according to product name
    v  -  according to weight
    l  -  according to length
    b  -  according to width
    h  -  according to height
    ?  -  prints this help text
    q  -  return to main page."

_WELCOME_TEXT="===============================================

    +====================================+
    |   Lasse's Logistics and Logic.     |
    |    We have several furniture!      |
    +====================================+

===============================================

Please select a menu option."

_MENU_OPTIONS="backup print sort help exit"
_SORTING_OPTIONS="id name weight length width height help main"
_INVALID_OPTION="Not a valid option! Please try again."
_PRESS_KEY="Press any key to continue..."


tabs -15
readArgs ${1} ${2} ${3}
exit 0
## ===============================================
