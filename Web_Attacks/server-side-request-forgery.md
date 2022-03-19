What is an SSRF?

SSRF stands for Server-Side Request Forgery. It's a vulnerability that allows a malicious user to cause the webserver to make an additional or edited HTTP request to the resource of the attacker's choosing.

Types of SSRF 

1. regular ssrf - input is visible on screen

2. blind ssrf - no input on screen 

What's the impact?
A successful SSRF attack can result in any of the following: 

1. Access to unauthorised areas.
2. Access to customer/organisational data.
3. Ability to Scale to internal networks.
4. Reveal authentication tokens/credentials.

---------

we can manipulate the url where resources are being requested like server= , url= , u = etc.

so we can provide another url into that query and retrieve data such as user , passwords , api keys etc. 

path transversal i.e dot dot slash can also be used here like ../user

"&x=" is used in case we retrive data from other subdomains of the same website 

we can also direct the website to our hackers domai / ip to learn about requests made by server and also capture API keys. 

--------

Potential SSRF vulnerabilities can be spotted in web applications in many different ways. Here is an example of four common places to look:

1. When a full URL is used in a parameter in the address bar:

2. A hidden field in a form: found by viewing page source 

3. A partial URL such as just the hostname:

4. Or perhaps only the path of the URL:

If working with a blind SSRF where no output is reflected back to you, you'll need to use an external HTTP logging tool to monitor requests such as requestbin.com, your own HTTP server or Burp Suite's Collaborator client.

----------

to prevent SSRF developers may use 

1. Allow list :- where all requests get denied other than allowed ones can be bypassed using creating subdomains of our choice 

2. Deny list :- where certain requests are being denied to be accessed . resources such as localhost are denied as it may contain sensitive server information i.e 127.0.0.1 which can be bypassed by alternative references to localhost for ex. 0, 0.0.0.0, 0000, 127.1, 127.*.*.*, 2130706433, 017700000001 or by redirecting to subdomains that have dns record which resolves to localhost

and as for cloud scenarios ip 169.254.169.254 is denied as it contain sensitive data about coud instances can be bypassed by subdomains with DNS record to this IP 

3. Open Redirect - An open redirection happens when a web application or server uses an unvalidated user-submitted link to redirect the user to a given website or page. - used to bypass strict rules . 

---------

