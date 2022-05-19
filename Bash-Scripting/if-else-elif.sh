#!/bin/bash

#if statement example to check age for college,

read -p 'What is Your Age:' age

if [ $age -lt 20 ]

then

 echo "You cannot go to college"

elif [ $age -gt 40 ]

then

 echo "You cannot go to college as you are above age of 40"

else

 echo "You can go to college"

fi


