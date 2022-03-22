Purpose of this : 

1. Which systems are up?

2. What services are running on these systems?

in this module we will focus on finding live systems using the tool <Nmap i.e NetworK Mapper>

different approaches of discovering live hosts over a network : 

1. ARP scan: This scan uses ARP requests to discover live hosts

2. ICMP scan: This scan uses ICMP requests to identify live hosts

3. TCP/UDP ping scan: This scan sends packets to TCP ports and UDP ports to determine live hosts.

--------

Steps in a nmap scan : 

1. enumeration

2. discover live host 

3. reverse dns lookup 

4. scan ports

5. detect versions

6. detect OS

7. traceroute 

8. scripts

9. writing outputs to a file 


-------

A network segment is a group of computers connected using a shared medium. medium can be the Ethernet switch or WiFi access point.

 a subnetwork is usually the equivalent of one or more network segments connected together and configured to use the same router.

 if we are in a same subnet we use ARP i.e address resolution protocol to discover live hosts as ARP uses link layer i.e based on MAC addresses , arp packets cannot be routed outside the subnet , ARP packets are bound to their subnet only 

 ---------

 we need to specify the targets we want to scan. Generally speaking, you can provide a list, a range, or a subnet. Examples of target specification are:

1. list: MACHINE_IP scanme.nmap.org example.com will scan 3 IP addresses.

2. range: 10.11.12.15-20 will scan 6 IP addresses: 10.11.12.15, 10.11.12.13.16,… and 10.11.12.13.20.

3. subnet: MACHINE_IP/30 will scan 4 IP addresses. 

You can also provide a file as input for your list of targets, <nmap -iL list_of_hosts.txt.>

nmap -sL TARGETS (This option will give you a detailed list of the hosts that Nmap will scan without scanning them) 

use -n if you want to disable dns lookup 

---------------

To discover live hosts we can use:

1. ARP from Link Layer (Address resolution protocol , MAC addresses)

2. ICMP from Network Layer (Ping Type8 (Echo) , Type0 ( Echo Reply ))

3. TCP from Transport Layer

4. UDP from Transport Layer

---------

Nmap host discovery using ARP requests : 

1. when root user scan targets on local network , nmap user ARP requests , 

2. when root user scans target outside of local network nmap uses ICMP echo i.e ping , tcp ack on port 80 and tcp syn on port 443 and icmp timestamp request. 

3. when non root user scans target outside local network , nmap uses complete tcp 3 way handshake 

<nmap -sn TARGETS> discover live hosts without scanning , just pinging 

<nmap -PR -sn TARGETS> ARP scan without any port scanning , arp only work inside local netowrk devices on a same subnet 

arp-scan , a scanner built for arp scanning , we can use it to scan all the host on local network as well as all the interfaces i.e lan wifi etc. 


-------

Nmap Host Discovery Using ICMP(ping) : 

We can ping every IP address on a target network and see who would respond to our ping (ICMP Type 8/Echo) requests with a ping reply (ICMP Type 0). 

but ping can sometimes also be blocked due to firewalls and newer version of windows also blocks ping 

<nmap -PE target> to perform ping scan 
	 
	 Adding the -PP option tells Nmap to use ICMP timestamp requests. if icmp echo i.e ping is blocked 

	   Nmap uses address mask queries (ICMP Type 17) and checks whether it gets an address mask reply (ICMP Type 18). This scan can be enabled with the option -PM.

------

Nmap Host Discovery Using TCP and UDP : 


1. TCP SYN ping : 

we can send a syn flag to any port and wait for syn-ack reply  if host is up we get syn-ack otherwise rst packet
	
	we use -PS21 OR -PS21-25 OR -PS80,21,443  to give a port to scan here 

	root users don't have to complete the 3 way handshake but non root users have to do the complete handshake 

2. TCP ACK ping : 

here we send a ack flag packet to a port and if get a rst reply it means host is up 

	syntax to specify port is same as above here we use -PA instead 

	*only root users can do this*

3. UDP ping : 

 so here we send a udp packet to the port

 if port is open data will go and no response will be there indicating port is open , 
 
 	if port is closed it sends a response i.e icmp port unreachable 

 	 sending a UDP packet to any closed UDP port can trigger a response indirectly indicating that the target is online.

 	 here the syntax is : 

 	 	<nmap -PU 10.10.68.220/24>	 
	

 
Masscan:

 Masscan uses a similar approach to discover the available systems. However, to finish its network scan quickly, Masscan is quite aggressive with the rate of packets it generates. 

 		The syntax is quite similar: -p can be followed by a port number, list, or range. Consider the following examples:

---------

Reverse DNS lookup : 

Nmap’s default behaviour is to use reverse-DNS online hosts. Because the hostnames can reveal a lot, this can be a helpful step. However, if you don’t want to send such DNS queries, you use -n to skip this step. 

you can use the option -R to query the DNS server even for offline hosts.

--------



Summary : 

Scan Type	            Example Command

ARP Scan	            sudo nmap -PR -sn MACHINE_IP/24

ICMP Echo Scan	        sudo nmap -PE -sn MACHINE_IP/24

ICMP Timestamp Scan	    sudo nmap -PP -sn MACHINE_IP/24

ICMP Address Mask Scan	sudo nmap -PM -sn MACHINE_IP/24

TCP SYN Ping Scan	    sudo nmap -PS22,80,443 -sn MACHINE_IP/30

TCP ACK Ping Scan	    sudo nmap -PA22,80,443 -sn MACHINE_IP/30

UDP Ping Scan	        sudo nmap -PU53,161,162 -sn MACHINE_IP/30

Remember to add -sn if you are only interested in host discovery without port-scanning. Omitting -sn will let Nmap default to port-scanning the live hosts.

Option	    Purpose

-n	        no DNS lookup

-R	        reverse-DNS lookup for all hosts

-sn	        host discovery only 	


------------