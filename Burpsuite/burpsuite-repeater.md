We will be covering how to use Repeater to manipulate and arbitrarily resend captured requests, as well as looking at some of the niftier options available in this awesome tool.

In layman's terms, it means we can take a request captured in the Proxy, edit it, and send the same request repeatedly as many times as we wish. Alternatively, we could craft requests by hand, much as we would from the CLI (Command Line Interface), using a tool such as cURL to build and send requests.

-------

Respones can have 4 display options i.e :- 


1. Pretty: This is the default option. It takes the raw response and attempts to beautify it slightly, making it easier to read.

2. Raw: The pure, un-beautified response from the server.

3. Hex: This view takes the raw response and gives us a byte view of it -- especially useful if the response is a binary file.

4. Render: The render view renders the page as it would appear in your browser. Whilst not hugely useful given that we would usually be interested in the source code when using Repeater, this is still a neat trick.

---------

Inspector Section 

it is a superb way to get a prettified breakdown of the requests and responses

1. Query Parameters, which refer to data being sent to the server in the URL.

2. Body Parameters, which do the same thing as Query Parameters, but for POST requests. Anything that we send as data in a POST request will show up in this section, once again allowing us to modify the parameters before re-sending

3. Request Cookies contain, as you may expect, a modifiable list of the cookies which are being sent with each request

4. Request Headers allow us to view, access, and modify (including outright adding or removing) any of the headers being sent with our requests

5. Response Headers show us the headers that the server sent back in response to our request. These cannot be edited (as we can't control what headers the server returns to us!).

--------------

