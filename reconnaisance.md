We will learn three command-line tools:

1. whois to query WHOIS servers
2. nslookup to query DNS servers
3. dig to query DNS servers


We use whois to query WHOIS records, while we use nslookup and dig to query DNS database records. These are all publicly available records and hence do not alert the target.

We will also learn the usage of two online services:

1. DNSDumpster
2. Shodan.io


These two online services allow us to collect information about our target without directly connecting to it.

--------

 “If you know the enemy and know yourself, your victory will not stand in doubt.”

 Reconnaissance (recon) can be defined as a preliminary survey to gather information about a target. to gain a foothold on target system. 

 we devide reconnaisance into : 

 1. Passive Reconnaissance
 
 2. Active Reconnaissance

 -----------

 Passive reconnaissance activities include many activities, for instance:


1. Looking up DNS records of a domain from a public DNS server.

2. Checking job ads related to the target website.

3. Reading news articles about the target company.

--------

Active reconnaissance, on the other hand, cannot be achieved so discreetly. It requires direct engagement with the target. Think of it like you check the locks on the doors and windows, among other potential entry points.

Examples of active reconnaissance activities include:

1. Connecting to one of the company servers such as HTTP, FTP, and SMTP.

2. Calling the company in an attempt to get information (social engineering).

3. Entering company premises pretending to be a repairman.

*active reconnaisance can lead to legal trouble if not authorized*

--------

Whois <command-line-tool> (Passive-Recon.)

whois is a request and response protocol

listens on TCP:43

Domain registrar maintains whois record , whois server replies to our query

we can obtain : 

1. domain registrar's name 

2. contact info like name addr. , ph. no. , 

3. creation/update/expiry dates

4. name server related to domain i.e DNS server

-----------

nslookup <command-line-tool> (Passive-recon)

nslookup stands for name server lookup used for getting ip of name servers , website and all 

we can also select query types 

query types :

A	  -     IPv4 Addresses

AAAA  -     IPv6 Addresses

CNAME -     Canonical Name

MX	  -     Mail Servers

SOA	  -     Start of Authority

TXT	  -     TXT Records

example : <nslookup -type=A tryhackme.com >

------------

dig <command-line-tool> (Passive-Recon) 

For more advanced DNS queries and additional functionality, you can use dig, the acronym for “Domain Information Groper,”

dig @SERVER DOMAIN_NAME TYPE

SERVER is the DNS server that you want to query.

DOMAIN_NAME is the domain name you are looking up.

TYPE contains the DNS record type (we can refer to above list of nslookup for that )

--------

DNS Dumpster <Online-Website> (Passive-Recon) 

DNS Dumpster is an online service that provide detailed information about dns queries it can also look for subdomains , dns servers , dns to ip etc. it is more comprehensive and detailed than above 2 tools 

just visit the website enter the domain.com and we are good to go 

---------

Shodan.io

 Shodan.io can be helpful to learn various pieces of information about the client’s network, without actively connecting to it. Furthermore, on the defensive side, you can use different services from Shodan.io to learn about connected and exposed devices belonging to your organization.

 it is like a search engine for online exposed devices and it indexes those into its database.

 Via this Shodan.io search result, we can learn several things related to our search, such as:

1. IP address

2. hosting company

3. geographic location

4. server type and version	

-----------

------------

Active Reconnaisance : 

Active reconnaissance requires you to make some kind of contact with your target. like actively scanning or making requests etc. 

note:- your actions will get logged on the device whom you may be scanning. logs can contain ip,time,frequncy etc. 

--------

Using Web Browser : 

The web browser can be a convenient tool, especially that it is readily available on all systems.

using inspection tools to get website structure , javascripts used etc. 

we can use addons/extensions such as : 

1. FoxyProxy lets you quickly change the proxy server you are using to access the target website.

2. User-Agent Switcher and Manager gives you the ability to pretend to be accessing the webpage from a different operating system or different web browser.

3. Wappalyzer provides insights about the technologies used on the visited websites.

-------------

Ping: 

 The primary purpose of ping is to check whether you can reach the remote system and that the remote system can reach you back.

 The objective of such a command is to ensure that the target system is online before we spend time carrying out more detailed scans to discover the running operating system and services.

if we do not recieve a reply after ping'ing a device it can have several reasons such as : 

1. The destination computer is not responsive; possibly still booting up or turned off, or the OS has crashed.

2. It is unplugged from the network, or there is a faulty network device across the path.

3. A firewall is configured to block such packets. 

4. Your system is unplugged from the network.

-----------

TraceRoute: 

As the name suggests, the traceroute command traces the route taken by the packets from your system to another host.

traceroute tries to discover the routers across the path from your system to the target system.

TTL decreases after each hop from router to router, ttl gets 0 packet gets dropped 

 TTL indicates the maximum number of routers/hops that a packet can pass through before being dropped;

  When a router receives a packet, it decrements the TTL by one before passing it to the next router. 

  To summarize, we can notice the following:

1. The number of hops/routers between your system and the target system depends on the time you are running traceroute. 

2. There is no guarantee that your packets will always follow the same route, even if you are on the same network or you repeat the traceroute command within a short time.

3. Some routers return a public IP address. You might examine a few of these routers based on the scope of the intended penetration testing.

4. Some routers don’t return a reply.

----------------

Telnet : 

From a security perspective, telnet sends all the data, including usernames and passwords, in cleartext. Sending in cleartext makes it easy for anyone

The TELNET (Teletype Network) protocol was developed in 1969 to communicate with a remote system via a command-line interface (CLI).

telnet default port is 23 

telnet can be used for banner grabbing as it works on tcp protocol 

we can use 

<telnet "ip/domain" "port"> 

	we also have to specify headers i.e GET and Host: header  in case we are grabbing a web-server banner

--------

Netcat : 

supports both TCP and UDP

It can function as a client that connects to a listening port; alternatively, it can act as a server that listens on a port of your choice.

using netcat as a client is same as telnet... 

nc ip/domain port


using netcat as a server : 

<nc -nlvp 8000>

	-l for listen mode 
	-p for port number specifying 
	-n numeric only i.e no use of dns for ip to hostname
	-v verbose 
	-vv very verbose
	-k keep listening even if client disconnects

-----------



