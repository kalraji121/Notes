File Inclusion 

In some scenarios, web applications are written to request access to files on a given system, including images, static text, and so on via parameters. 

Parameters are query parameter strings attached to the URL that could be used to retrieve data or perform actions based on user input.

example 


http://webapp.thm/get.php?file=userCV.pdf

so here 

 http is protocol being used

 webapp.thm is the domain name

 ? is the query string 

 file is the parameter 

 userCV.pdf is the file being requested 

-------------------

Path Traversal

Also known as Directory traversal, a web security vulnerability allows an attacker to read operating system resources, such as local files on the server running an application.

abusing url to locate and access system files 

test out the URL parameter by adding payloads to see how the web application behaves

Path traversal attacks, also known as the dot-dot-slash attack, take advantage of moving the directory one step up using the double dots ../. If the attacker finds the entry point, which in this case get.php?file=, then the attacker may send something as follows, http://webapp.thm/get.php?file=../../../../etc/passwd


'file_get_content' function of php causes path transversal or dot dot slash attack or poor validation of user input can also be the cause 


---------------------


LFI - local file inclusion 


LFI attacks against web applications are often due to a developers' lack of security awareness. With PHP, using functions such as include, require, include_once, and require_once

LFI vulnerabilities also occur when using other languages such as PHP,ASP,JSP, or even in Node.js apps. LFI exploits follow the same concepts as path traversal.

There can be 2 cases here 


CASE 1 

where developer uses only get function to get files which can be directly manipulated by specifying file name with directory[direcly use /etc/passwd]


CASE 2 

where developer uses include function to include a directory with the get function which can be bypassed by path transversal i.e using ../../../../etc/[passwd]

CASE 3 

here the thing is that developer can sometimes be smart and add .php .exe .jsp or file that you may try to include so what happens is if i include ../../../../etc/passwd , the "passwd" file becomes and "passwd.php" so to bypass this php we can use Null Bytes

null bytes are url encoded string which looks like %00 or 0x00 which is used to terminate any string that will occour after this %00 meaning we use ../../../../etc/passwd%00 and .php string that is added forcefully there gets removed


CASE 4 

sometimes developers will filter and block specific keywords to be accessed in request for a file here is /etc/passwd file is filtered where we can bypass this using null bytes again after passwd or add /. at the end to get directed back to same directory and open the file again

CASE 5 

sometimes developer can filter our ../../../ whole as a keyword so here what we can do is use ....//....//....// 

Why did this work?

This works because the PHP filter only matches and replaces the first subset string ../ it finds and doesn't do another pass, leaving what is pictured below.

../../../../

CASE 6 

 Finally, we'll discuss the case where the developer forces the include to read from a defined directory! For example, if the web application asks to supply input that has to include a directory such as: http://webapp.thm/index.php?lang=languages/EN.php then, to exploit this, we need to include the directory in the payload like so: ?lang=languages/../../../../../etc/passwd.


 ----------------

 Remote File Inclusion - RFI

Remote File Inclusion (RFI) is a technique to include remote files and into a vulnerable application. Like LFI, the RFI occurs when improperly sanitizing user input, allowing an attacker to inject an external URL into include function. One requirement for RFI is that the allow_url_fopen option needs to be on.

The risk of RFI is higher than LFI since RFI vulnerabilities allow an attacker to gain Remote Command Execution (RCE) on the server. Other consequences of a successful RFI attack include:
Sensitive Information Disclosure
Cross-site Scripting (XSS)
Denial of Service (DoS)


An external server must communicate with the application server for a successful RFI attack where the attacker hosts malicious files on their server. Then the malicious file is injected into the include function via HTTP requests, and the content of the malicious file executes on the vulnerable application server.

basically we can supply a http://domain.com/file.php to be included on site and executed as well 

-----------------------

Remediation

As a developer, it's important to be aware of web application vulnerabilities, how to find them, and prevention methods. To prevent the file inclusion vulnerabilities, some common suggestions include:


1. Keep system and services, including web application frameworks, updated with the latest version.

2. Turn off PHP errors to avoid leaking the path of the application and other potentially revealing information.

3. A Web Application Firewall (WAF) is a good option to help mitigate web application attacks.

4. Disable some PHP features that cause file inclusion vulnerabilities if your web app doesn't need them, such as allow_url_fopen on and allow_url_include.

5. Carefully analyze the web application and allow only protocols and PHP wrappers that are in need.

6. Never trust user input, and make sure to implement proper input validation against file inclusion.

7. Implement whitelisting for file names and locations as well as blacklisting.

-------------------




