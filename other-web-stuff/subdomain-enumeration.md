It is the process of enumerating valid subdomains or parts of a valid domain. 

there are 3 methods of doing this i.e :- 

1. bruteforce 

2. osint 

3. virtual host 

-------------------

1. SSL/TLS certificates (OSINT)

we can enumerate subdomains by checking certificate logs that are publically availaible on : - 

sites like https://crt.sh and https://transparencyreport.google.com/https/certificates 

2. Search Engine (OSINT)

using google dorks such as site:*tryhackme.com or site:www.tryhackme.com


3. DNS Bruteforce

Bruteforce DNS (Domain Name System) enumeration is the method of trying tens, hundreds, thousands or even millions of different possible subdomains from a pre-defined list of commonly used subdomains.

tools : - 

DNS recon 

4. Sublist3r (OSINT based CLI tool)

use of sublist3r tool to list subdomains to a website 

5. Virtual Host 

Some subdomains aren't always hosted in publically accessible DNS results, such as development versions of a web application or administration portals.

Instead, the DNS record could be kept on a private DNS server or recorded on the developer's machines in their hosts file. which maps domain names to IP addresses. 


Because web servers can host multiple websites from one server when a website is requested from a client, the server knows which website the client wants from the Host header. We can utilise this "host" header by making changes to it and monitoring the response to see if we've discovered a new website.



"user@machine$ ffuf -w /usr/share/wordlists/SecLists/Discovery/DNS/namelist.txt -H "Host: FUZZ.acmeitsupport.thm" -u http://10.10.185.201 -fs {size}"


-w switch to specify the wordlist we are going to use.
-H switch adds/edits a header (in this instance, the Host header),
  we have the FUZZ keyword in the space where a subdomain would normally go, and this is where we will try all the options from the wordlist.

Because the above command will always produce a valid result, we need to filter the output. 
We can do this by using the page size result with the -fs switch. 
Edit the below command replacing {size} with the most occurring size value from the previous result and try it on the AttackBox.



