#!/bin/bash

# example of || operators

if [ $USER == 'kali' ] || [ $HOSTNAME == 'pwn' ]
then
 echo "one statement is true"

else
 echo "one statement is incorrect"

fi
#!/bin/bash


