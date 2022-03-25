Metasploit is the most widely used exploitation framework. Metasploit is a powerful tool that can support all phases of a penetration testing engagement, from information gathering to post-exploitation.


it has two verisons : 

1. Pro - paid and more features 

2. framework/community - free and less features than pro 

The Metasploit Framework is a set of tools that allow information gathering, scanning, exploitation, exploit development, post-exploitation, and more. While the primary usage of the Metasploit Framework focuses on the penetration testing domain, it is also useful for vulnerability research and exploit development.

The main components of the Metasploit Framework can be summarized as follows;

1. msfconsole: The main command-line interface.

2. Modules: supporting modules such as exploits, scanners, payloads, etc.

3. Tools: Stand-alone tools that will help vulnerability research, vulnerability assessment, or penetration testing.

use <msfconsole> command to launch metasploit CLI 

	some fundaments to keep in mind : 

	1. Exploit: A piece of code that uses a vulnerability present on the target system.

	2. Vulnerability: A design, coding, or logic flaw affecting the target system.

	3. Payload: An exploit will take advantage of a vulnerability. However, if we want the exploit to have the result we want (gaining access to the target system, read confidential information, etc.), we need to use a payload. Payloads are the code that will run on the target system.



Encoders: Encoders will allow you to encode the exploit and payload in the hope that a signature-based antivirus solution may miss them.

Evasion: While encoders will encode the payload, they should not be considered a direct attempt to evade antivirus software, because evain directly tries to evade antivirus 

Exploits: Exploits, neatly organized by target system.

NOPs: NOPs (No OPeration) do nothing, literally.

They are represented in the Intel x86 CPU family they are represented with 0x90, following which the CPU will do nothing for one cycle. They are often used as a buffer to achieve consistent payload sizes.

Payloads: Payloads are codes that will run on the target system.

Exploits will leverage a vulnerability on the target system, but to achieve the desired result, we will need a payload. Examples could be; getting a shell, loading a malware or backdoor to the target system, running a command, or launching calc.exe as a proof of concept to add to the penetration test report. 

---

types of payloads : 

1. Singles: Self-contained payloads (add user, launch notepad.exe, etc.) that do not need to download an additional component to run.

2. Stagers: Responsible for setting up a connection channel between Metasploit and the target system. Useful when working with staged payloads. “Staged payloads” will first upload a stager on the target system then download the rest of the payload (stage). This provides some advantages as the initial size of the payload will be relatively small compared to the full payload sent at once.

3. Stages: Downloaded by the stager. This will allow you to use larger sized payloads.


Post: Post modules will be useful on the final stage of the penetration testing process i.e more info gathering , more access , more sensitive files like hashes retrival etc. 

------

msfconsole: 

it is our mail CLI we will use throughout a pentest : 

it can accept all standard linux commands while being in console mode 

clear -  to clear the terminal 

help "command" to get help for a command in msfconsole 

history -  to list all the used commands till now 

we can use search "vulnerable software" to search for a exploit 

search <type:auxiliary telnet> to filter type to a auxilary. 

use <set "option_name" "option_value"> to set a option in a module

use <show options> to list all the available options to be set in a module 

<run> or <exploit> to run a module after we set options in it 

<info> for more information about a module 

   "use <"path/to/exploit"> or "id""of module listed after search to load a module 

You can use the <setg> command to set values that will be used for all modules. and <unsetg> to unset that value globally

	