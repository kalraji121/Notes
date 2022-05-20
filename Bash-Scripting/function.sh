#!/bin/bash

function print_me {

echo "i am a print , which is called by a function"

}

print_me

function username {

echo "I am also a function and i provide username if the machine i run on"

echo "$HOSTNAME"

}

username
