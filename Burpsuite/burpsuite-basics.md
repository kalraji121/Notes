 Burp Suite is a framework written in Java that aims to provide a one-stop-shop for web application penetration testing. In many ways, this goal is achieved as Burp is very much the industry standard tool for hands-on web app security assessments. Burp Suite is also very commonly used when assessing mobile applications, as the same features which make it so attractive for web app testing translate almost perfectly into testing the APIs (Application Programming Interfaces) powering most mobile apps.

burp suite can monitor , intercept , manipulate request send to a web server. 


---------

features of burp suite : - 

1. Proxy :- the Burp Proxy allows us to intercept and modify requests/responses when interacting with web applications.

2. Repeater :- allows us to capture, modify, then resend the same request numerous times , very valuable for payload generation in SQLi attacks 

3. Intruder :-  spray an endpoint with requests. This is often used for bruteforce attacks or to fuzz endpoints.

4. Decoder :-  decoding captured information, or encoding a payload prior to sending it to the target. 

5. Comparer :- allows us to compare two pieces of data at either word or byte level.

6. Sequencer :-  We usually use Sequencer when assessing the randomness of tokens such as session cookie values or other supposedly random generated data. 

If the algorithm is not generating secure random values, then this could open up some devastating avenues for attack.

7. Modules:- modules are also very helpful for extending the functionality of burpsuite in various cases . modules are available in BApp store in Burpsuite 

-------------

There are 2 options which can be used to configure our burpsuite 

1. Global settings can be found in the User options tab along the top menu bar. (made changes to everything)

2. Project-specific settings can be found in the Project options tab.(specific changes according to a project , can ovveride global settings)

---------------

Burp Proxy :-

The Burp Proxy is the most fundamental (and most important!) of the tools available in Burp Suite. It allows us to capture requests and responses between ourselves and our target. These can then be manipulated or sent to other tools for further processing before being allowed to continue to their destination.

----------  

Scope Settings :- 

It can get extremely tedious having Burp capturing all of our traffic. When it logs everything (including traffic to sites we aren't targeting), it muddies up logs we may later wish to send to clients. In short, allowing Burp to capture everything can quickly become a massive pain.

What's the solution? Scoping.

Setting a scope for the project allows us to define what gets proxied and logged. We can restrict Burp Suite to only target the web application(s) that we want to test. The easiest way to do this is by switching over to the "Target" tab, right-clicking our target from our list on the left, then choosing "Add To Scope". Burp will then ask us whether we want to stop logging anything which isn't in scope -- most of the time we want to choose "yes" here.

--------

Target Options Tab :- 

Site map - allows us to map out the apps we are targeting in a tree structure. Every page that we visit will show up here, allowing us to automatically generate a site map for the target simply by browsing around the web app

Issue Definitions: Whilst we don't have access to the Burp Suite vulnerability scanner in Burp Community, we do still have access to a list of all the vulnerabilities it looks for. 
