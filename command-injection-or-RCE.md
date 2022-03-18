Command injection :-

is the abuse of an application's behaviour to execute commands on the operating system, using the same privileges that the application on a device is running with

A command injection vulnerability is also known as a "Remote Code Execution" (RCE) because an attacker can trick the application into executing a series of payloads that they provide, without direct access to the machine itself (i.e. an interactive shell)


---------------

Discovering command Injection or RCE 

This vulnerability exists because applications often use functions in programming languages such as PHP, Python and NodeJS to pass data to and to make system calls on the machine’s operating system. 

Abusing applications in this way can be possible no matter the programming language the application uses. As long as the application processes and executes it, it can result in command injection

------------

Exploiting Command Injection :- 

You can often determine whether or not command injection may occur by the behaviours of an application

use shell operators to execute additional commands  For example, the shell operators ;, & and && will combine two (or more) system commands and execute them both


Two types/ways of command injection :- 

1. Blind - no direct output on screen , investigate the behaviour to confirm 

2. Verbose - direct feedback from the application . output visible on webpage 



Detection Blind Command Injection

we may use payloads that causes time delay like sleep or ping 

or we can force some output by using redirection operators such as " > " to redirect the output of a command to a file and cat that file out for us 

use curl to deliver data to and from an application in your payload



Detecting Verbose Command Injection 

easy af as the output will be visible related to command used 



----

Payloads :- 

Linux 

whoami , ls , ping , sleep , nc (reverse shell purposes)


Windows 

whoami , dir , ping , timeout (hangs the application)

--------

Remediation/Prottection/Prevention of command injection 

1. do not use vulnerable functions in any programming language used for designing a website i.e php,python etc. 

2. Input sanitization i.e blocking of several vulnerable operators , commands etc. 

-------





