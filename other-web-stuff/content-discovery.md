Content can be many things, a file, video, picture, backup, a website feature. 

There are three main ways of discovering content on a website which we'll cover. Manually, Automated and OSINT (Open-Source Intelligence).


Manually 

1. Robots.txt

The robots.txt file is a document that tells search engines which pages they are and aren't allowed to show on their search engine results or ban specific search engines from crawling the website altogether. 

2. Favicon

The favicon is a small icon displayed in the browser's address bar or tab used for branding a website.

Sometimes when frameworks are used to build a website, a favicon that is part of the installation gets leftover, and if the website developer doesn't replace this with a custom one, this can give us a clue on what framework is in use. OWASP host a database of common framework icons that you can use to check against the targets favicon https://wiki.owasp.org/index.php/OWASP_favicon_database. 

3. Sitemap.xml

Unlike the robots.txt file, which restricts what search engine crawlers can look at, the sitemap.xml file gives a list of every file the website owner wishes to be listed on a search engine. 

4. HTTP Headers

When we make requests to the web server, the server returns various HTTP headers. These headers can sometimes contain useful information such as the webserver software and possibly the programming/scripting language in use. Try running the below curl command against the web server, where the -v switch enables verbose mode, which will output the headers

5. Framework stack 

visit framework website , read changelogs , notes , documentation etc. to gain more info ..

----------------------------------------------------------------------------------------------

OSINT - open source intelligence 

1. Google Hacking / Dorking

Google hacking / Dorking utilizes Google's advanced search engine features, which allow you to pick out custom content. 


Example


site
site:tryhackme.com
returns results only from the specified website address

inurl
inurl:admin
returns results that have the specified word in the URL

filetype
filetype:pdf
returns results which are a particular file extension

intitle
intitle:admin
returns results that contain the specified word in the title

2. Wappalyzer

Wappalyzer (https://www.wappalyzer.com/) is an online tool and browser extension that helps identify what technologies a website uses, such as frameworks, Content Management Systems (CMS), payment processors and much more, and it can even find version numbers as well.

3. Wayback Machine

The Wayback Machine (https://archive.org/web/) is a historical archive of websites that dates back to the late 90s. You can search a domain name, and it will show you all the times the service scraped the web page and saved the contents. This service can help uncover old pages that may still be active on the current website.

4. GitHub

To understand GitHub, you first need to understand Git. Git is a version control system that tracks changes to files in a project.

You can use GitHub's search feature to look for company names or website names to try and locate repositories belonging to your target. Once discovered, you may have access to source code, passwords or other content that you hadn't yet found.

5. S3 Buckets

S3 Buckets are a storage service provided by Amazon AWS, allowing people to save files and even static website content in the cloud accessible over HTTP and HTTPS.

The owner of the files can set access permissions to either make files public, private and even writable. Sometimes these access permissions are incorrectly set and inadvertently allow access to files that shouldn't be available to the public.

The format of the S3 buckets is http(s)://{name}.s3.amazonaws.com where {name} is decided by the owner,

--------------------------------

Automated Discovery :- 

Automated discovery is the process of using tools to discover content rather than doing it manually.

tools for content discovery are :- 

1. ffuf 

user@machine$ ffuf -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -u http://10.10.39.215/FUZZ

2. Dirb 

user@machine$ dirb http://10.10.39.215/ /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt

3. Gobuster

user@machine$ gobuster dir --url http://10.10.39.215/ -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt

4. Diruster (GUI based)

all these tool requires a wordlist i.e a list of words made for content discovery most preferrable is *Seclist*
