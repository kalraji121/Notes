 we focus on how Nmap can be used to:

1. Detect versions of the running services (on all open ports)

2. Detect the OS based on any signs revealed by the target

3. Run Nmap’s traceroute

4. Run select Nmap scripts

5. Save the scan results in various formats

---------

Service Detection : 

Once Nmap discovers open ports, you can probe the available port to detect the running service. 

finding specific versions of software running on a system can help us in vulnerability assesment

Adding <-sV> to your Nmap command will collect and determine service and version information for the open ports. 

You can control the intensity with --version-intensity LEVEL where the level ranges between 0, the lightest, and 9, the most complete. -sV --version-light has an intensity of 2, while -sV --version-all has an intensity of 9.

it is compulsory to do a complete 3 way TCP handshake in a service scan so stealth scan is not posible with service scan 

-------

 OS Detection and Traceroute : 

 OS Detection
Nmap can detect the Operating System (OS) based on its behaviour and any telltale signs in its responses. OS detection can be enabled using <-O> this is an uppercase O as in OS. In this example, we ran nmap -sS -O MACHINE_IP

 Nmap needs to find at least one open and one closed port on the target to make a reliable guess. Furthermore, the guest OS fingerprints might get distorted due to the rising use of virtualization and similar technologies. Therefore, always take the OS version with a grain of salt. 

 Traceroute:

  If you want Nmap to find the routers between you and the target, just add --traceroute

 example : <nmap -sS --traceroute MACHINE_IP>

--------

Nmap Scripting Engine (NSE)

A part of Nmap, Nmap Scripting Engine (NSE) is a Lua interpreter that allows Nmap to execute Nmap scripts written in Lua language. 

check the files at "/usr/share/nmap/scripts", and you will notice that there are hundreds of scripts conveniently named starting with the protocol they target. 

Let’s begin with the default scripts. You can choose to run the scripts in the default category using --script=default or simply adding -sC.
or you can use --script=Script_Category  script categories are given below :


Script Category                   Description

auth                              Authentication related scripts

broadcast                         Discover hosts by sending broadcast messages

brute                             Performs brute-force password auditing against logins

default                           Default scripts, same as -sC

discovery                         Retrieve accessible information, such as database tables and DNS names

dos                               Detects servers vulnerable to Denial of Service (DoS)

exploit                           Attempts to exploit various vulnerable services

external                          Checks using a third-party service, such as Geoplugin and Virustotal

fuzzer                            Launch fuzzing attacks

intrusive                         Intrusive scripts such as brute-force attacks and exploitation

malware                           Scans for backdoors

safe                              Safe scripts that won’t crash the target

version                           Retrieve service versions

vuln                              Checks for vulnerabilities or exploit vulnerable services



example : <sudo nmap -sS -sC MACHINE_IP>

If you are unsure what a script does, you can open the script file with a text reader, such as less, or a text editor. 

You can also specify the script by name using --script "SCRIPT-NAME" or a pattern such as --script "ftp*" 


------------

Saving The Output  :

Whenever you run a Nmap scan, it is only reasonable to save the results in a file. Selecting and adopting a good naming convention for your filenames is also crucial. The number of files can quickly grow and hinder your ability to find a previous scan result. The three main formats are:

1. Normal

2. Grepable (grep-able)

3. XML

There is a fourth one that we cannot recommend:

1. Script Kiddie

--------

1. Normal

As the name implies, the normal format is similar to the output you get on the screen when scanning a target.

Syntax : -oN FILENAME

2. Grepable 

Grepable
The grepable format has its name from the command grep; grep stands for Global Regular Expression Printer. In simple terms, it makes filtering the scan output for specific keywords or terms efficient. 

You can save the scan result in grepable format using -oG FILENAME. 

3. XML
The third format is XML. You can save the scan results in XML format using -oX FILENAME. The XML format would be most convenient to process the output in other programs.

        Conveniently enough, you can save the scan output in all three formats using -oA FILENAME to combine -oN, -oG, and -oX for normal, grepable, and XML.

4. Script Kiddie

A fourth format is script kiddie. You can see that this format is useless if you want to search the output for any interesting keywords or keep the results for future reference.

 However, you can use it to save the output of the scan nmap -sS 127.0.0.1 -oS FILENAME, display the output filename, and look 31337 in front of friends who are not tech-savvy.

-----------

Summary : 

Option                       Meaning
-sV                          determine service/version info on open ports

-sV --version-light          try the most likely probes (2)

-sV --version-all            try all available probes (9)

-O                           detect OS

--traceroute                 run traceroute to target

--script=SCRIPTS             Nmap scripts to run

-sC or --script=default      run default scripts

-A                           equivalent to -sV -O -sC --traceroute

-oN                          save output in normal format

-oG                          save output in grepable format

-oX                          save output in XML format

-oA                          save output in normal, XML and Grepable formats
