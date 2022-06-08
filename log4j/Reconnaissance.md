---
title: 'Reconnaissance '
updated: 2022-06-07 13:31:57Z
created: 2022-06-07 12:48:12Z
---

we have vulnerable **log4j** vulnerability present in our lab so lets begin with basic scanning and enumeration as we normally would .
so lets perform a nmap scan :

![6cefbf965cf80c8a6df8d494086a7022.png](../_resources/6cefbf965cf80c8a6df8d494086a7022.png)

results : 

![6316e6cc9224377ad61b5cd8d3b98f66.png](../_resources/6316e6cc9224377ad61b5cd8d3b98f66.png)

so there are three ports ports open lets enumerate this 8983 port further : 

![39f3a524c79d535645036cbed639bcfc.png](../_resources/39f3a524c79d535645036cbed639bcfc.png)

so there is apache solr running on this port which is vulnerable to log4j