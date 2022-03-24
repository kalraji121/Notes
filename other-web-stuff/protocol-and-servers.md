today we will learn about some common protocols such as : 

1. HTTP

2. FTP 

3. POP3

4. SMTP

5. IMAP

we will understand what happens on the low level and is usually hidden by an elegant GUI (Graphical User Interface). 

We will “talk” using the above protocols using a simple Telnet client to fully understand what your GUI client is doing under the hood. 

Our purpose is not to memorize the protocol commands but rather to get a closer look at the protocol while it is working.

--------

Telnet : 

The Telnet protocol is an application layer protocol used to connect to a virtual terminal of another computer.

Using Telnet, a user can log into another computer and access its terminal (console) to run programs, start batch processes, and perform system administration tasks remotely.

Unfortunately, all this communication between the Telnet client and the Telnet server is not encrypted, making it an easy target for attackers.

PORT : 23

-------

HTTP - HYPER TEXT TRANSFER PROTOCOL : 

Hypertext Transfer Protocol (HTTP) is the protocol used to transfer web pages. Your web browser connects to the webserver and uses HTTP to request HTML pages and images among other files and submit forms and upload various files. Anytime you browse the World Wide Web (WWW), you are certainly using the HTTP protocol.

HTTP sends and receives data as cleartext (not encrypted)

PORT : 80 

we can send a http request via telnet and nc as follows : 

GET /index HTTP/1.1
host: telnet 

then press enter two times 

-------

FTP - FILE TRANSFER PROTOCOL : 

FTP also sends and receives data as cleartext; therefore, we can use Telnet (or Netcat) to communicate with an FTP server and act as an FTP client.

PORT : 21

we can use telnet or nc to connect 

We needed to provide the username with the command USER frank.

Then, we provided the password with the command PASS D2xc9CgD.

A command like STAT can provide some added information. The SYST command shows the System Type of the target (UNIX in this case). PASV switches the mode to passive. It is worth noting that there are two modes for FTP:

1. Active: In the active mode, the data is sent over a separate channel originating from the FTP server’s port 20.

2. Passive: In the passive mode, the data is sent over a separate channel originating from an FTP client’s port above port number 1023.

The command TYPE A switches the file transfer mode to ASCII, while TYPE I switches the file transfer mode to binary.

we will have to use a ftp client to actually download a file 

use ls to list files and get "filename" to download a file from ftp server 

-------

SMTP - Simple Mail Transfer Protocol : 


Email is one of the most used services on the Internet. There are various configurations for email servers; for instance, you may set up an email system to allow local users to exchange emails with each other with no access to the Internet.

Email delivery over the Internet requires the following components:

1. Mail Submission Agent (MSA) - submission agent / checks for messages and errors 

2. Mail Transfer Agent (MTA) - recieves mail from mail submission agent and then send it to MTA of revciever 

3. Mail Delivery Agent (MDA) - can also be included in MTA , it delivers our mail finally 

4. Mail User Agent (MUA) - sender / reciever 

Simple Mail Transfer Protocol (SMTP) is used to communicate with an MTA server. Because SMTP uses cleartext, where all commands are sent without encryption

PORT : 25 

------

POP3

Post Office Protocol version 3 (POP3) is a protocol used to download the email messages from a Mail Delivery Agent (MDA) server, as shown in the figure below. The mail client connects to the POP3 server, authenticates, downloads the new email messages before (optionally) deleting them.

PORT : 110

it is also a cleartext protocol 

------

IMAP -Internet Message Access Protocol : 

Internet Message Access Protocol (IMAP) is more sophisticated than POP3. IMAP makes it possible to keep your email synchronized across multiple devices (and mail clients). In other words, if you mark an email message as read when checking your email on your smartphone, the change will be saved on the IMAP server (MDA) and replicated on your laptop when you synchronize your inbox.

It is clear that IMAP sends the login credentials in cleartext, as we can see in the command LOGIN frank D2xc9CgD. Anyone watching the network traffic would be able to know Frank’s username and password.

PORT : 143

-----------

Summary : 

Protocol	  TCP Port	         Application(s)	   Data Security

FTP	            21	             File Transfer	   Cleartext

HTTP	        80	             Worldwide Web	   Cleartext

IMAP	       143	             Email (MDA)	   Cleartext

POP3	       110	             Email (MDA)	   Cleartext

SMTP	        25	             Email (MTA)	   Cleartext

Telnet	        23	             Remote Access	   Cleartext

--------
  




