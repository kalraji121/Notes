terminal commands scripted to run one by one by itself from a file is called basic shell scripting.

ends with ".sh"

must have executable permissions (chmod + x)

and a she-bang notation in its start like this "#!/bin/bash"

use a hashtag # to give comments which are not ran as a code .

-------------------------------------------------------
echo -  to print a string to the terminal .

use ./script.sh to execute this file . 

----------------------------------------

Variables : 

named places to store temporary data ,

we can create / declare variable by :

name=sanskar (a simple variable "name" , holding the value "kalra")

add a dollar sign before the variable to refer to it .

echo $name 

case sensitivity is must .

----------------------------

Argumnents :

not all bash scripts require arguments , but still its worth to know how they are interpreted and dealt with.

arguments ?

ls -la /var/www/html

here "-la" and "/var/www/html" both are the arguments passed to the command . 

so to give our script some arguments , 

----------------------------------------

miscellaneous : use :

echo $RANDOM - to generate a random number 

-------------------------------------------

Reading User Input (Read) : 

we can also get input from user who is interacting with the script using "read" 

it is done like :

read variable_name

echo $variable_name 

then there are 2 arguments that go with read command:

-p to make user-input visible on terminal (good for usernames)

-sp to silent the user-input on terminal (good for passwords)

-----------------------------------------

If - Else - and Elif: (conditional statements)


-lt to indicate less than (these can be more like -gt etc.)


use if to specify a condition is met and if it is met then do a task

use "else" to do a task in case our "if" statement is false 

if you want to add more conditions then if and else , use elif in between if and else to add more conditions.

--------------

Boolean Logical Opearators:

example : "&&" "||"

"&&" operator - if the first command result is true then only it proceeds to next one (and operator). it check that both statements should be true.

"||" operator is opposite of && operator , it executes the next command only if previous is false. (or operator).
it implies that only one statement should be true 

------------------------------------

Loops :

repetitive task until a set of criteria is met .

there are 2 loops we will discuss here :

1. for loops 

2. while loops 

-> for loops;

used to perform a given set of commands for each of the item in a list .

basic syntax :

for variable_name in <list>
do 
 <action to perform>
done


 for ip in $(seq 1 10); do echo 10.11.1.$ip; done -> use of seq command


 for i in {1..10}; do echo 10.10.10.$i;done -> use of brace expnsion



----


-> while loops

while [ <some test> ]

do 

 <perform an action>

done


-----------

Functions : 

function is like script inside a script ,

useful when we have to run the same code multiple time 

write the long code and make it a function

call that function whenever needed .

