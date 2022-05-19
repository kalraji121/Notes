#!/bin/bash

#use of -sp to hide input from terminal and -p to show input on terminal:


echo "Welcome to Credential Storing Service"

read -p 'Username: ' username

read -sp 'Password:' password 

echo "[+] Credentials Stored"

echo "Your username is $username and Your Password is $password"
