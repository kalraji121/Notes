Intruder allows us to automate requests, which is very useful when fuzzing or bruteforcing.

--------

Intruder is Burp Suite's in-built fuzzing tool. 

It allows us to take a request and use it as a template to send many more requests with slightly altered values automatically. 

we can bruteforce login-forms and also fuzz a web-app 

There are four other Intruder sub-tabs:

1. Positions: allows us to select an Attack Type.  as well as configure where in the request template we wish to insert our payloads.

2. Payloads: allows us to select values to insert into each of the positions we defined in the previous sub-tab.	

3. Resource Pool : helps to divide our resources between tasks . 

4. Options : The settings here apply primarily to how Burp handles results and how Burp handles the attack itself. for ex. we can flag requests that contains certain pieces of text. 

-----------

Working With Positions Tab Area :

1. the first thing we need to do is look at positions. Positions tell Intruder where to insert payloads.

2. selected positions are highlighted in green and surrounded by silcrows (§).

there are 3 buttons here i.e :-

a. add : that lets us add the highlited text as positions 

b. clear : that removes all the defined positions 

c. auto : that automatically selects the positions for us (not preferrable mot of the times)

-------------

Attack Types : 

There are four attack types available:

1. Sniper

2. Battering ram

3. Pitchfork

4. Cluster bomb

--------

<Sniper>

Sniper is the first and most common attack type.

When conducting a sniper attack, we provide one set of payloads. For example, this could be a single file containing a wordlist or a range of numbers.

Sniper is very good for single-position attacks (e.g. a password bruteforce if we know the username or fuzzing for API endpoints). 

it fuzzes it position one by one . 

--------

<Battering-Ram>

Like Sniper, Battering ram takes one set of payloads (e.g. one wordlist). Unlike Sniper, the Battering ram puts the same payload in every position rather than in each position in turn.

example if our payload include these 3 words i.e burp,suite,intruder

there will be 3 requests made i.e 

<username=burp&password=burp>

<username=suite&password=suite>

<username=intruder&password=intruder>

-----------

<Pitchfork>

 Pitchfork as being like having numerous Snipers running simultaneously. 

Pitchfork uses one payload set per position up to a maximum of 20 payload sets and goes through them all at once 

 Pitchfork takes the first item from each list and puts them into the request, one per position and then second items of both then thirds and so on. 

 it will do it until one of the list runs out . so list should be of identical length 

This attack type is exceptionally useful when forming things like credential stuffing attacks. 

-----------

<Cluster-Bomb>

Cluster bomb allows us to choose multiple payload sets: one per position, up to a maximum of 20; however, whilst Pitchfork iterates through each payload set simultaneously, Cluster bomb iterates through each payload set individually, making sure that every possible combination of payloads is tested.

Cluster Bomb will iterate through every combination of the provided payload sets to ensure that every possibility has been tested. 

 this is another extremely useful attack type for any kind of credential bruteforcing where a username isn't known.

-----------

Payloads Creation and stuff:

understand how to create, assign, and use payloads.

"Payloads" sub-tab; this is split into four sections:

1.  Payload Sets section allows us to choose which position we want to configure a set for as well as what type of payload we would like to use.

*in case of single payload attack type we will have only one option in payload set but in case of more multiple payload attack types we will have multiple options in payload se dropdown menu* . 

2. Payload Options differ depending on the payload type we select for the current payload set.

a "Simple List" payload type will give us a box to add and remove payloads to and from the set

"Add" text box, paste lines in with "Paste", or "Load..." from a file. The "Remove" button removes the currently selected line only. The "Clear" button clears the entire list. 

3. Payload Processing : allows us to define rules to be applied to each payload in the set before being sent to the target. For example, we could capitalise every word or skip the payload if it matches a regex. 

4. Payload Encoding section : This section allows us to override the default URL encoding options that are applied automatically to allow for the safe transmission of our payload.

-----------





CSRF token and session cookie (Optional)

here we used macro to capture the loginToken and session cookies which is unique with each and every refresh to bruteforce admin password so this was a big one as our macro will change the csrf token as well as session cookie in our request before request is sent.

steps to create a macro :  -

1. Switch over to the "Project Options" tab, then the "Sessions" sub-tab.

2. Scroll down to the bottom of the sub-tab to the "Macros" section and click the "Add" button.

3. The menu that appears will show us our request history.

4. With the request selected, click Ok.

5. Finally, give the macro a suitable name, then click "Ok" again to finish the process.


next :  set Session Handling rules that define how the macro should be used.

1. Still in the "Sessions" sub-tab of Project Options, scroll up to the "Session Handling Rules" section and choose to "Add" a new rule.

2. A new window will pop up with two tabs in it: "Details" and "Scope". We are in the Details tab by default.

3. Fill in an appropriate description, then switch over to the Scope tab.

4. In the "Tools Scope" section, deselect every checkbox other than Intruder -- we do not need this rule to apply anywhere else.

5. In the "URL Scope" section, choose "Use suite scope"; this will set the macro to only operate on sites that have been added to the global scope (as was discussed in Burp Basics). If you have not set a global scope, keep the "Use custom scope" option as default and add http://MACHINE_IP/ to the scope in this section.

next : we need to switch back over to the Details tab and look at the "Rule Actions" section.

1. Click the "Add" button -- this will cause a dropdown menu to appear with a list of actions we can add.

2. Select "Run a Macro" from this list.

3. In the new window that appears, select the macro we created earlier.

next :  we should restrict which parameters and cookies are being updated before we start our attack:

1. Select "Update only the following parameters", then click the "Edit" button next to the input box below the radio button.

2. In the "Enter a new item" text field, type "loginToken". Press "Add", then "Close".

3. Select "Update only the following cookies", then click the relevant "Edit" button.

4. Enter "session" in the "Enter a new item" text field, press "Add", then "Close".

5. Finally, press "Ok" to confirm our action.

