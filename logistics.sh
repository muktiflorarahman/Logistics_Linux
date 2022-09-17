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
    if [[ ${#} == 0 ]]; then
        goodbye ${noArgs}
    fi
}
## ===============================================

## function handles command line arguments
## ===============================================
function goodbye() {
    clear
    echo 
    echo ${@}
    echo 
    echo ${startAgain}
    echo 
}
## ===============================================




## main program starts here
## ===============================================
clear

## creating variables
file1=${1}
noArgs="first argument must be the data file"
noFile="file ${file1} does not exist"
startAgain="Please try to start the program again."


readArgs ${1} ${2} ${3}
exit 0
## ===============================================
