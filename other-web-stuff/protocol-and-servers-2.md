Servers implementing the previous module protocols are subject to different kinds of attacks. To name a few, consider:

1. Sniffing Attack (Network Packet Capture)

2. Man-in-the-Middle (MITM) Attack

3. Password Attack (Authentication Attack)

4. Vulnerabilities

-----

1.  Sniffing Attack : 

Sniffing attack refers to using a network packet capture tool to collect information about the target. When a protocol communicates in cleartext, the data exchanged can be captured by a third party to analyse. A simple network packet capture can reveal information, such as the content of private messages and login credentials, if the data isn't encrypted in transit.

There are many programs available to capture network packets. We consider the following:

1. Tcpdump: is a free open source command-line interface (CLI) program that has been ported to work on many operating systems.

2. Wireshark:  is a free open source graphical user interface (GUI) program available for several operating systems, including Linux, macOS and MS Windows.

3. Tshark:  is a CLI alternative to Wireshark.

all cleartext protocols are vulnerable to this attack when the attacker have access to the communication channel betweeen network. 

---------

MITM - man in the middle : 

A Man-in-the-Middle (MITM) attack occurs when a victim (A) believes they are communicating with a legitimate destination (B) but is unknowingly communicating with an attacker (E). 

This attack is relatively simple to carry out if the two parties do not confirm the authenticity and integrity of each message

Any time you browse over HTTP, you are susceptible to a MITM attack, and the scary thing is that you cannot recognize it. Many tools would aid you in carrying out such an attack, 
	such as Ettercap and Bettercap.

	MITM can also affect other cleartext protocols such as FTP, SMTP, and POP3. Mitigation against this attack requires the use of cryptography. The solution lies in proper authentication along with encryption or signing of the exchanged messages. With the help of Public Key Infrastructure (PKI) and trusted root certificates, Transport Layer Security (TLS) protects from MITM attacks.

--------

TLS - transport layer security : 

we learn about a standard solution to protect the confidentiality and integrity of the exchanged packets. The following approach can protect against password sniffing and MITM attacks.

An existing cleartext protocol can be upgraded to use encryption via SSL/TLS.

Protocol	Default Port	      Secured Protocol	        Default Port with TLS

HTTP	        80	                   HTTPS	                  443

FTP	            21	                   FTPS	                      990

SMTP	        25	                   SMTPS	                  465

POP3	       110	                   POP3S	                  995

IMAP	       143	                   IMAPS	                  993

example : 

http communication with a website has 2 steps i.e [Unsecure]

1. tcp connection 

2. sending of requests 

https communication with a website has 3 steps i.e [Secure]

1. tcp connection 

2. ssl/tls connection - To establish an SSL/TLS connection, the client needs to perform the proper handshake with the server.

3. sending of requests 



ssl/tsl connection summary : . A client was able to agree on a secret key with a server that has a public certificate. This secret key was securely generated so that a third party monitoring the channel wouldn’t be able to discover it. Further communication between the client and the server will be encrypted using the generated key.

Consequently, once an SSL/TLS handshake has been established, HTTP requests and exchanged data won’t be accessible to anyone watching the communication channel.

dns over tls is called DOT 


--------

SSH - secure shell 

Secure Shell (SSH)  a secure way for remote system administration. In other words, it lets you securely connect to another system over the network and execute commands on the remote system. , which can be summarized simply as:

1. You can confirm the identity of the remote server

2. Exchanged messages are encrypted and can only be decrypted by the intended recipient

3. Both sides can detect any modification in the messages

PORT : 22

 you can connect to an SSH server using the following command ssh username@MACHINE_IP

 We can use SSH to transfer files using SCP (Secure Copy Protocol) based on the SSH protocol.

  An example of the syntax is as follows: scp mark@MACHINE_IP:/home/mark/archive.tar.gz ~. This command will copy a file named archive.tar.gz from the remote system located in the /home/mark directory to ~, i.e., the root of the home directory of the currently logged-in user.

Another example syntax is scp backup.tar.bz2 mark@MACHINE_IP:/home/mark/. This command will copy the file backup.tar.bz2 from the local system to the directory /home/mark/ on the remote system.

---------

Password Attack : 

Many protocols require you to authenticate. Authentication is proving who you claim to be. 

Authentication, or proving your identity, can be achieved through one of the following, or a combination of two:

1. Something you know, such as password and PIN code.

2. Something you have, such as a SIM card, RFID card, and USB dongle.

3. Something you are, such as fingerprint and iris.




Attacks against passwords are usually carried out by:

1. Password Guessing: Guessing a password requires some knowledge of the target, such as their pet’s name and birth year.

2. Dictionary Attack: This approach expands on password guessing and attempts to include all valid words in a dictionary or a wordlist.

3. Brute Force Attack: This attack is the most exhaustive and time-consuming where an attacker can go as far as trying all possible character combinations, which grows fast

------

we can automate dictionary attacks with THC hydra : the password cracking tool of industry 

Hydra supports many protocols, including FTP, POP3, IMAP, SMTP, SSH, and all methods related to HTTP. The general command-line syntax is: <hydra -l username -P wordlist.txt server service > where we specify the following options:

	-l username: -l should precede the username, i.e. the login name of the target.

	-P wordlist.txt: -P precedes the wordlist.txt file, which is a text file containing the list of passwords you want to try with the provided username.

	server is the hostname or IP address of the target server.
	
	service indicates the service which you are trying to launch the dictionary attack.



There are some extra optional arguments that you can add:

	-s PORT to specify a non-default port for the service in question.
	
	-V or -vV, for verbose, 
	
	-t n where n is the number of parallel connections to the target. -t 16 will create 16 threads used to connect to the target.
	
	-d, for debugging, to get more detailed information about what’s going on. 

	Once the password is found, you can issue CTRL-C to end the process.

-----

Protection/Prevention of password attacks : 

	Password Policy: Enforces minimum complexity constraints on the passwords set by the user.
	
	Account Lockout: Locks the account after a certain number of failed attempts.
	Throttling Authentication Attempts: Delays the response to a login attempt. 

	Using CAPTCHA: Requires solving a question difficult for machines. It works well if the login page is via a graphical user interface (GUI). (Note that CAPTCHA stands for Completely Automated Public Turing test to tell Computers and Humans Apart.)

	Requiring the use of a public certificate for authentication. This approach works well with SSH, for instance.
	
	Two-Factor Authentication: Ask the user to provide a code available via other means, such as email, smartphone app or SMS.

	There are many other approaches that are more sophisticated or might require some established knowledge about the user, such as IP-based geolocation.


Using a combination of the above approaches is an excellent approach to protect against password attacks.

---------




