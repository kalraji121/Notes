you are going to be introduced to:

1. What vulnerabilities are

2. Why they're worthy of learning about

3. How are vulnerabilities rated

4. Databases for vulnerability research

5. A showcase of how vulnerability research is used on ACKme's engagement

--------

Introduction to Vulnerabilities : 

A vulnerability in cybersecurity is defined as a weakness or flaw in the design, implementation or behaviours of a system or application.

An attacker can exploit these weaknesses to gain access to unauthorised information or perform unauthorised actions.

categories of vulnerabilities : 

1. Operating System:

These types of vulnerabilities are found within Operating Systems (OSs) and often result in privilege escalation.

2. (Mis)Configuration-based:

These types of vulnerability stem from an incorrectly configured application or service. For example, a website exposing customer details.

3. Weak or Default Credentials:

Applications and services that have an element of authentication will come with default credentials when installed. if we do not change those credentials it can be harmful 

4. Application Logic

These vulnerabilities are a result of poorly designed applications. For example, poorly implemented authentication mechanisms that may result in an attacker being able to impersonate a user.

5. Human-Factor

Human-Factor vulnerabilities are vulnerabilities that leverage human behaviour. For example, phishing emails are designed to trick humans into believing they are legitimate. i.e social engeneering 

--------

Scoring Vunerabilities : 

Vulnerability management is the process of evaluating, categorising and ultimately remediating threats (vulnerabilities) faced by an organisation.

It is arguably impossible to patch and remedy every single vulnerability in a network or computer system and sometimes a waste of resources.

    it is all about addressing the most dangerous vulnerabilities

Vulnerability scoring serves a vital role in vulnerability management and is used to determine the potential risk and impact a vulnerability may have on a network or computer system.


Vulnerability scoring framework : 

1. Common Vulnerability Scoring System (CVSS) 

 a score is essentially determined by some of the following factors (but many more):

  1. How easy is it to exploit the vulnerability?

  2. Do exploits exist for this?

  3. How does this vulnerability interfere with the CIA triad?



2. Vulnerability Priority Rating (VPR)

The VPR framework is a much more modern framework in vulnerability management - developed by Tenable, an industry solutions provider for vulnerability management.

This framework is considered to be risk-driven; meaning that vulnerabilities are given a score with a heavy focus on the risk a vulnerability poses to the organisation itself   

-----------

Vulnerability Databases : 

there are resources on the internet that keep track of vulnerabilities for all sorts of software, operating systems and more!

some fundamentals before going to vulnerability databases : 

1. Vulnerability:

A vulnerability is defined as a weakness or flaw in the design, implementation or behaviours of a system or application.

2. Exploit:

An exploit is something such as an action or behaviour that utilises a vulnerability on a system or application.

3. Proof of Concept (PoC):	

A PoC is a technique or tool that often demonstrates the exploitation of a vulnerability.



we will use two websites that source these databases of vulnerabilities : 

1.  NVD (National Vulnerability Database)

2.  Exploit-DB

-------


1. NVD (National Vulnerability Database)


The National Vulnerability Database is a website that lists all publically categorised vulnerabilities. In cybersecurity, vulnerabilities are classified under “Common Vulnerabilities and Exposures” (Or CVE for short).

These CVEs have the formatting of CVE-YEAR-IDNUMBER. For example, the vulnerability that the famous malware WannaCry used was CVE-2017-0144.

While this website helps keep track of new vulnerabilities, it is not great when searching for vulnerabilities for a specific application or scenario.

2. Exploit-DB


Exploit-DB is a resource that we, as hackers, will find much more helpful during an assessment. Exploit-DB retains exploits for software and applications stored under the name, author and version of the software or application.

We can use Exploit-DB to look for snippets of code (known as Proof of Concepts) that are used to exploit a specific vulnerability.

-------

