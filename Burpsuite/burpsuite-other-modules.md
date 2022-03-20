Burp Suite also has several slightly more obscure modules built-in: 

we will be looking at the Decoder, Comparer and Sequencer tools. These allow us to: work with encoded text; compare sets of text; and analyse the randomness of captured tokens, respectively. Being able to perform these relatively straightforward tasks directly within Burp Suite can save a lot of time

-------

Decoder : 

The Burp Suite Decoder module allows us to manipulate data. As the name suggests, we can decode information that we capture during an attack, but we can also encode data of our own, ready to be sent to the target. Decoder also allows us to create hashsums of data, as well as providing a Smart Decode feature which attempts to decode provided data recursively until it is back to being plaintext (like the "Magic" function of Cyberchef). 

Let's take a closer look at the manual encoding and decoding options. : 

1. Plain: Plaintext is what we have before performing any transformations.

2. URL: URL encoding is used to make data safe to transfer in the URL of a web request. It involves exchanging characters for their ASCII character code in hexadecimal format, preceded by a percentage symbol (%). Url encoding is an extremely useful method to know for any kind of web application testing.

3. HTML: Encoding text as HTML Entities involves replacing special characters with an ampersand (&) followed by either a hexadecimal number or a reference to the character being escaped, then a semicolon (;). For example, a quotation mark has its own reference: &quot;

4. Base64: Another widely used encoding method, base64 is used to encode any data in an ASCII-compatible format. It was designed to take binary data (e.g. images, media, programs) and encode it in a format that would be suitable to transfer over virtually any medium. 

5. ASCII Hex: This option converts data between ASCII representation and hexadecimal representation. For example, the word "ASCII" can be converted into the hexadecimal number "4153434949".

6. Hex, Octal, and Binary: These encoding methods all apply only to numeric inputs. They convert between decimal, hexadecimal, octal (base eight) and binary.

7. Gzip: Gzip provides a way to compress data. It is widely used to reduce the size of files and pages before they are sent to your browser. Smaller pages mean faster loading times, which is highly desirable for developers looking to increase their SEO score and avoid annoying their customers. 

double encoding :- means encoding a encoded text to other methods 

Smart Decode:

Finally, let's take a look at the "Smart Decode" option. This feature of Decoder attempts to automatically decode encoded text.

-------

Hashing : 

Decoder also gives us the option to generate hashsums for our entered data.

Hashing is a one-way process that is used to transform data into a unique signature.

*To be a hashing algorithm, the resulting output must be impossible to reverse. A good hashing algorithm will ensure that every piece of data entered will have a completely unique hash.*

For this reason, hashes are frequently used to verify the integrity of files and documents, as even a very small change to the file will result in the hashsum changing significantly.

*Equally, hashes are also used to securely store passwords as (due to the one-way hashing process meaning that the hashes can never be reversed) the passwords will be (relatively) secure even if the database is leaked. When a user creates a password, it is hashed and stored by the application. When the user tries to log in, the application will then hash the password they submit and check it against the stored hash; if the hashes match, then the password was correct.*

*we have to convert hashed content to ASCII hex as hashing does not return a text value so converting/encoding to ASCII hex is a must to get an actual hash*


--------

Comparer : 

Comparer allows us to compare two pieces of data, either by ASCII words or by bytes.

it is very simple to use you can compare two pieces together for example we can send 2 different responses to comparer and check the differences easily either at word level or at byte level 


---------

Sequencer : 

, Sequencer allows us to measure the entropy (or randomness, in other words) of "tokens" -- strings that are used to identify something and should, in theory, be generated in a cryptographically secure manner.

Entropy, in cyber security, is a measure of the randomness or diversity of a data-generating function.

For example, we may wish to analyse the randomness of a session cookie or a Cross-Site Request Forgery (CSRF) token protecting a form submission.

if it turns out that these tokens are not generated securely, then we can (in theory) predict the values of upcoming tokens. Just imagine the implications of this if the token in question is used for password resets...

--------

There are two main methods we can use to perform token analysis with Sequencer:

1. Live Capture : 

 Live capture allows us to pass a request to Sequencer, which we know will create a token for us to analyse. 

 what sequencer does here is we send it a request to sequence it then send the request and capture the cookie sent by server and then send thousands of same request to get more of those cookies and tokens and it anaylyzes those data/samples for us to check entropy of server 

2. Manual load: 
 It allows us to load a list of pre-generated token samples straight into Sequencer for analysis. Using Manual Load means we don't have to make thousands of requests to our target (which is both loud and resource intensive), but it does mean that we need to obtain a large list of pre-generated tokens!

 -------

 the more tokens are captured in sequencer , it is better for us and after around 10,000 tokens we can stop or pause and click on anaylyze now to get a summarized result of tokens captured and conclude results about entropy. 

 






