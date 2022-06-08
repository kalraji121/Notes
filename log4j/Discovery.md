---
title: Discovery
updated: 2022-06-07 13:44:29Z
created: 2022-06-07 13:32:16Z
---

so lets visit this web-page : on port 8983

![24d1b7ee7374d36dbbe75d502aff4b6b.png](../_resources/24d1b7ee7374d36dbbe75d502aff4b6b.png) this shows some information about the apache solr that is being used here . 

we found the logs directory : **highlighted in blue**

![8751cb4126ff8245db01508ec19a6164.png](../_resources/8751cb4126ff8245db01508ec19a6164.png)

some logs are given to us in task that help us to see logs and find our attack surface/area: 

log file : 

![70ff56575c9d2eb5d8fe1498a200c595.png](../_resources/70ff56575c9d2eb5d8fe1498a200c595.png)

lets read and enumerate useful data out of this : 

we can see path , the location on webpage that has been visited several times : 

![636921ff88f932d892c1c4c76e9f1c51.png](../_resources/636921ff88f932d892c1c4c76e9f1c51.png)

i.e /admin/cores

then there is a params column that is controlled by user : 

![0e19c4f0c9def163b868a9ff6bcf88b4.png](../_resources/0e19c4f0c9def163b868a9ff6bcf88b4.png)

so as we can see we have a specific directory and a user directed input field .