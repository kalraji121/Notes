#!/bin/bash

#if statement example to check age for college,

read -p 'What is Your Age:' age

if [ $age -lt 20 ]

then

 echo "You cannot go to college"

fi


