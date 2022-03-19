What is an IDOR?

IDOR stands for Insecure Direct Object Reference and is a type of access control vulnerability.

This type of vulnerability can occur when a web server receives user-supplied input to retrieve objects (files, data, documents), too much trust has been placed on the input data, and it is not validated on the server-side to confirm the requested object belongs to the user requesting it.

-----------

Encoded ID's 

https://www.base64decode.org/ to decode and encode these id's

Encoding changes binary data into an ASCII string commonly using the a-z, A-Z, 0-9 and =character for padding. 

Encoding ensures that the receiving web server will be able to understand the contents

--------------

Hashed ID's

Hashed IDs are a little bit more complicated to deal with than encoded ones, but they may follow a predictable pattern, such as being the hashed version of the integer value. For example, the Id number 123 would become 202cb962ac59075b964b07152d234b70 if md5 hashing were in use.

use https://crackstation.net/ to decrypt and manipulate these values 

-------------------

Unpredictable IDs

If the Id cannot be detected using the above methods, an excellent method of IDOR detection is to create two accounts and swap the Id numbers between them. If you can view the other users' content using their Id number while still being logged in with a different account (or not logged in at all), you've found a valid IDOR vulnerability.

-------------------

where are IDOR vuln. located ?

not always in adress bar but can be present in AJAX requests or a JS file 

we can use developer tools and network tab to see request going on to the server and edit and resend those request to discover an idor.

