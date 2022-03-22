so advanced scans basically manipulate or change or combine different tcp flags to see what happens and work on those to scan a host 

 We will cover the following types of port scans:

1. Null Scan

2. FIN Scan

3. Xmas Scan

4. Maimon Scan

5. ACK Scan

6. Window Scan

7. Custom Scan

Moreover, we will cover the following:

1. Spoofing IP

2. Spoofing MAC

3. Decoy Scan

4. Fragmented Packets

5. Idle/Zombie Scan

We will discuss options and techniques to evade firewalls and IDS systems. We also cover options to get more verbose details from Nmap.

--------

1. Null Scan : 

it does not have any flag set ,  all flags set to zeroo

syntax : -sN 

if we get no response means port is either open or filtered 

if we get rst back to us it means port is closed 

*it requires root privileges*  

2. FIN Scan : 

it has all the same logic as above null scan but it only sends FIN flag set in its request 

Syntax : -sF 

3. Xmas Scan : 

Xmas scan sets the FIN, PSH, and URG flags simultaneously. You can select Xmas scan with the option 

Syntax : -sX.

it also has same logic as above to detect closed and open ports

*On scenario where these three scan types can be efficient is when scanning a target behind a stateless (non-stateful) firewall. A stateless firewall will check if the incoming packet has the SYN flag set to detect a connection attempt. Using a flag combination that does not match the SYN packet makes it possible to deceive the firewall and reach the system behind it.*

-----------

TCP Maimon Scan : 

it has FIN and ACK bits set , we recieve RST packet as a response here 

won't work on most target systems in modern network 

Syntax : -sM 

linux bsd systems drop packet in case of an open port 

---------

TCP ACK Scan : 

an ACK scan will send a TCP packet with the ACK flag set.

we get RST as a response regardless if the port is open or closed 

Syntax: -sA

This kind of scan would be helpful if there is a firewall in front of the target. you will learn which ports were not blocked by the firewall. In other words, this type of scan is more suitable to discover firewall rule sets and configuration.



TCP Window Scan : 

Another similar scan is the TCP window scan. The TCP window scan is almost the same as the ACK scan; however, it examines the TCP Window field of the RST packets returned. On specific systems, this can reveal that the port is open. You can select this scan type with the option 

Syntax : -sW 

this is also more suitable to discover firewall rule sets and configuration 


Custom Scan : 

we can also set the flags we want as we desire .  to map the firewal even better than before 

 For instance, if you want to set SYN, RST, and FIN simultaneously, you can do so using --scanflags RSTSYNFIN

if you develop your custom scan, you need to know how the different ports will behave to interpret the results in different scenarios correctly.

even if a port appeared to be closed|filtered or open|filtered it does not mean that an actual service is running behind that 

-----------------------------

Spoofing and Decoys : 

we can spoof our IP address as well as MAC address to hide our idenetity 

Syntax : 

		nmap -S sppofed_ip target_ip        // use -e to specify network interface 

so here what happens is we send a request with our source id being spoofed to another ip

then the results of that is send to spoofed ip as , spoofed ip becomes destination ip here 

then we monitor the network traffic and capture the replies of spoofed user to conclude results here 

*attacker needs to monitor network traffic to anaylyze the replies*



when we are on same subnet we can also spoof our mac to something else. 

syntax: --spoof-mac spoofed_mac


Decoys : The concept is simple, make the scan appears to be coming from many IP addresses so that the attacker’s IP address would be lost among them.  

Syntax :  nmap -D 10.10.0.1,10.10.0.2,RND,RND,ME 10.10.11.39      // here all other ip's are decoys i.e fake and RND makes our ip random , ME means our own IP and the last ip in this list is the ip we want to scan . 


----------

Fragmented Packets : 


Firewall :- A firewall is a piece of software or hardware that permits packets to pass through or blocks them. It functions based on firewall rules, summarized as blocking all traffic with exceptions or allowing all traffic with exceptions. 

IDS :- An intrusion detection system (IDS) inspects network packets for select behavioural patterns or specific content signatures. It raises an alert whenever a malicious rule is met.

Nmap provides the option -f to fragment packets. Once chosen, the IP data will be divided into 8 bytes or less. Adding another -f (-f -f or -ff) will split the data into 16 byte-fragments instead of 8. You can change the default value by using the --mtu; however, you should always choose a multiple of 8.

what fragmentation does is it divided our ip data into multiple fragments or pieces for example -f divides our ip of 24 bytes into 8+8+8

and the more the number of -f or -ff or -fff the multiple of 8 will be used to divide the IP data . 

what fragmentation can help is to bypass firewall by diving our ip data to bypass certain signatures of activities 

On the other hand, if you prefer to increase the size of your packets to make them look innocuous, you can use the option 
--data-length NUM, where num specifies the number of bytes you want to append to your packets.

--------

Idle / Zombie Scan 


Syntax : nmap -sI ZOMBIE_IP MACHINE_IP, where ZOMBIE_IP is the IP address of the idle host (zombie).

The idle (zombie) scan requires the following three steps to discover whether a port is open:

1. Trigger the idle host to respond so that you can record the current IP ID on the idle host.

2. Send a SYN packet to a TCP port on the target. The packet should be spoofed to appear as if it was coming from the idle host (zombie) IP address.

3. Trigger the idle machine again to respond so that you can compare the new IP ID with the one received earlier.

IP ID plays a major role here and most importantly *idle machine or zombie machine should be completely idle and free so that IP ID data retrieved can be reliable for us to conclude the state of a port*

--------

You might consider adding --reason if you want Nmap to provide more details regarding its reasoning and conclusions.

-v for verbosity in output and -vv for even more verbosity 

-d for debugging details and -dd for even more debugging details 

---------

Summary : 

Port Scan Type	                   Example Command

TCP Null Scan	                   sudo nmap -sN 10.10.253.50

TCP FIN Scan	                   sudo nmap -sF 10.10.253.50

TCP Xmas Scan	                   sudo nmap -sX 10.10.253.50

TCP Maimon Scan	                   sudo nmap -sM 10.10.253.50

TCP ACK Scan	                   sudo nmap -sA 10.10.253.50

TCP Window Scan	                   sudo nmap -sW 10.10.253.50

Custom TCP Scan	                   sudo nmap --scanflags URGACKPSHRSTSYNFIN 10.10.253.50

Spoofed Source IP	               sudo nmap -S SPOOFED_IP 10.10.253.50

Spoofed MAC Address	               --spoof-mac SPOOFED_MAC

Decoy Scan	                        nmap -D DECOY_IP,ME 10.10.253.50

Idle (Zombie) Scan	                sudo nmap -sI ZOMBIE_IP 10.10.253.50

Fragment IP data into 8 bytes	   -f

Fragment IP data into 16 bytes	   -ff

-------------

  Option	                        Purpose
--source-port PORT_NUM              specify source port number

--data-length NUM                   append random data to reach given length

-------------


These scan types rely on setting TCP flags in unexpected ways to prompt ports for a reply. Null, FIN, and Xmas scan provoke a response from closed ports, while Maimon, ACK, and Window scans provoke a response from open and closed ports.

Option	    Purpose
--reason	explains how Nmap made its conclusion

-v	        verbose

-vv	        very verbose

-d	        debugging

-dd	        more details for debugging


------------




