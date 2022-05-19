#!/bin/bash

counter=1

while [ $counter -le 10 ]

do

 echo "10.10.10.$counter"
 ((counter++))
done
