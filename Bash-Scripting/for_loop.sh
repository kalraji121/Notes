#!/bin/bash

#for loop using brace expansion

for ip in {1..10};

do
 echo "10.10.10.$ip";
done
