Introduction to Meterpreter: 

Meterpreter is a Metasploit payload that supports the penetration testing process with many valuable components.

Meterpreter will run on the target system and act as an agent within a command and control architecture. You will interact with the target operating system and files and use Meterpreter's specialized commands.

how does it work : 

it runs but never installs , it runs in RAM to avoid AV detection, it runs just like a process 

meterpreter uses encryption for communication so it bypasses IPS and IDS easyyy

use "getpid" command to get process id of meterpreter 

---------

Meterpreter Flavours : 

metasploit payloads can be divided into two categories : 

1. inline/single - The inline payloads are sent in a single step. 

2. Staged - staged payloads are sent to the target in two steps. An initial part is installed (the stager) and requests the rest of the payload. This allows for a smaller initial payload size.

list meterpreter versions : <msfvenom --list payloads | grep meterpreter>


Meterpreter versions are available for the following platforms;

1. Android

2. Apple iOS

3. Java

4. Linux

5. OSX

6. PHP

7. Python

8. Windows

our decision on which version of Meterpreter to use will be mostly based on three factors;

1. operating system of the target 

2. components installed on target system for ex. python , php 

3. Network connection types you can have with the target system ex. tcp or https etc. 

---------


Commands In Meterpreter : 

just use help command while in a meterpreter session and all the commands will be listed with description 

--------

Post Exploitation :

Meterpreter provides you with many useful commands that facilitate the post-exploitation phase.

use help to also list all post explotations commands 

1. The <getuid> command will display the user with which Meterpreter is currently running.

2. The <ps> command will list running processes.

3. Migrate

Migrating to another process will help Meterpreter interact with it. example migrate with notepad to capture key strokes by these 3 commands <keyscan_start, keyscan_stop, and keyscan_dump>

beware : if you merge with a low privilege process your privileges on that system will decrease 

4. Hashdump

The hashdump command will list the content of the SAM database. The SAM (Security Account Manager) database stores user's passwords on Windows systems. These passwords are stored in the NTLM (New Technology LAN Manager) format.


then use cracking tools , rainbow tables to crack the hash and get clear text password , 


5. Search

The search command is useful to locate files with potentially juicy information. 

example <search -f flag2.txt>

6. Shell

The shell command will launch a regular command-line shell on the target system. Pressing CTRL+Z will help you go back to the Meterpreter shell.

-----


