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
    fi
    
    #if arg is 1 then we want to check if the arg is valid or not
    # checks if data file exists or not
    # if data file does not exist
    if [[ ${#} == 1 ]]; then
        if test -f "$_DATA_FILE"; then
            echo welcome
        elif [[ "$_DATA_FILE" == "$_HELP" ]]; then
            usage  
        else    
            goodbye "$_DATA_FILE" "$_NO_FILE"
        fi
    fi

    #if arg is 2 then we want to check if a switch is given in the command prompt
    if [[ ${#} == 2 ]]; then
        if test -f "$_DATA_FILE"; then
            if [[ "$_OPTIONAL_ARG" == "-b" || "$_OPTIONAL_ARG" == "--backup" ]]; then
                echo backup
            elif [[ "$_OPTIONAL_ARG" == "-p" || "$_OPTIONAL_ARG" == "--print" ]]; then
                echo print
            elif [[ "$_OPTIONAL_ARG" == "-s" || "$_OPTIONAL_ARG" == "--sort" ]]; then
                usage
            else
                goodbye "$_OPTIONAL_ARG" "$_INVALID_ARG"
            fi
        else    
            goodbye "$_DATA_FILE" "$_NO_FILE" 
        fi

    fi
}
## ===============================================
## ===============================================

function usage() {
    echo "$_USAGE"
    exit 0
}

## ===============================================

## function for 
## ===============================================
function goodbye() {
    #${@} - arg that is sent to the function
    echo ${@}
    echo 
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


readArgs ${1} ${2} ${3}
exit 0
## ===============================================
