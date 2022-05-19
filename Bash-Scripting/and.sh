#!/bin/bash

# example of && operators

if [ $USER == 'kali' ] && [ $HOSTNAME == 'kali' ]
then
 echo "both statements are true"

else
 echo "one statement is incorrect"

fi
