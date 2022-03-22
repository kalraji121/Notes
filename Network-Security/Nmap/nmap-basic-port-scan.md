here we will look at : 

	1. TCP connect port scan
	2. TCP SYN port scan
	3. UDP port scan
	
	Moreover, we discuss the different options to specify the ports, the scan rate, and the number of parallel probes.

-------

TCP and UDP ports basics : 

a TCP port or UDP port is used to identify a network service running on that host. 

A port is usually linked to a service using that specific port number. 

 Furthermore, no more than one service can listen on any TCP or UDP port (on the same IP address).

ports are divided into two states : 

	1. Open : some service is listening on this port 

	2. Closed : no service is listening on that port 

but, 

to consider the impact of firewall nmap divides port into six states : 

1. Open : port is open and listening 

2. Closed : port is closed and not listening and there is no impact of firewall here 

3. Filtered : port state cannot be determined due to firewall 

4. Unfiltered : state cannot be determined but port is accessible 

5. Open|Filtered : cannot decide wether port is open or filtered 

6. Closed|Filtered : cannot determine wether port is closed or filtered 

----------

TCP Flags : 

tcp flags are set inside tcp header , setting a flag means setting its value to 1 and 0 to unset a flag , 

Flags : 

1. URG: Urgent flag indicates that the urgent pointer filed is significant. The urgent pointer indicates that the incoming data is urgent, and that a TCP segment with the URG flag set is processed immediately without consideration of having to wait on previously sent TCP segments.

2. ACK: Acknowledgement flag indicates that the acknowledgement number is significant. It is used to acknowledge the receipt of a TCP segment.

3. PSH: Push flag asking TCP to pass the data to the application promptly.

4. RST: Reset flag is used to reset the connection. Another device, such as a firewall, might send it to tear a TCP connection. This flag is also used when data is sent to a host and there is no service on the receiving end to answer.

5. SYN: Synchronize flag is used to initiate a TCP 3-way handshake and synchronize sequence numbers with the other host. The sequence number should be set randomly during TCP connection establishment.

6. FIN: The sender has no more data to send.

--------

TCP Connect Scan : 

here 3 way hanshake is done (SYN , SYN-ACK , ACK) if we recieve syn-ack back means port is open  

syntax : 
		
		<nmap -sT target> , can be done by both root and non root user 
		-F to scan 100 most common ports 
		-r to scan consecutively 

-----

TCP SYN Scan : also known as stealth scan 

it is a defaut scan for only root users

it does not complete the whole 3 way handshake , it does : SYN , SYN-ACK , RST

Syntax : 

		<nmap -sS target>

-------

UDP Scan 

it is a connectionless protocol that means it follows no flags as tcp does , 

if a UDP packet is sent to a closed port, an ICMP port unreachable error (type 3, code 3) is returned. sending a UDP packet to an open port won’t tell us anything.

simply said if we do not get any response from a port it means it is open 

Syntax : 

		 <nmap -sU 10.10.36.161>

-------

Fine-Tuning Scans and Performance : 

we can specify port by using -p 80,69 etc or -p 100-150

use -p- to scan all 65535 ports 

-F to scan only top 100 ports i.e common 100 ports 

--top-ports 10 to scan top 10 ports means common top 10

we can use -T<0-5> to control scan timing and probes frequency timing for ex. -T1 OR -T0 

	there are six templates:

      paranoid (0)
      
      sneaky (1)
      
      polite (2)
      
      normal (3)
      
      aggressive (4)
      
      insane (5)

 -T4 is good for CTF's 

 -T1 is good for real world engagement

 -T3 is default i.e normal 


 Alternatively, you can choose to control the packet rate using --min-rate <number> and --max-rate <number>. For example, --max-rate 10 or --max-rate=10 ensures that your scanner is not sending more than ten packets per second.

 	Moreover, you can control probing parallelization using --min-parallelism <numprobes> and --max-parallelism <numprobes>. Nmap probes the targets to discover which hosts are live and which ports are open; probing parallelization specifies the number of such probes that can be run in parallel. For instance, --min-parallelism=512 pushes Nmap to maintain at least 512 probes in parallel; these 512 probes are related to host discovery and open ports.

---------

Summary : 

Port Scan Type	       Example Command

TCP Connect Scan	   nmap -sT 10.10.36.161

TCP SYN Scan	       sudo nmap -sS 10.10.36.161

UDP Scan	           sudo nmap -sU 10.10.36.161

These scan types should get you started discovering running TCP and UDP services on a target host.

Option	        Purpose

-p-	                      all ports

-p1-1023	              scan ports 1 to 1023

-F	                      100 most common ports

-r	                      scan ports in consecutive order

-T<0-5>	                 -T0 being the slowest and T5 the fastest

--max-rate 50	          rate <= 50 packets/sec

--min-rate 15	          rate >= 15 packets/sec

--min-parallelism 100	  at least 100 probes in parallel



