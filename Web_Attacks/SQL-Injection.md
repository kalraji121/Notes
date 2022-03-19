SQL (Structured Query Language) Injection, 

mostly referred to as SQLi, is an attack on a web application database server that causes malicious queries to be executed. When a web application communicates with a database using input from a user that hasn't been properly validated, there runs the potential of an attacker being able to steal, delete or alter private and customer data and also attack the web applications authentication methods to private or customer areas. This is why as well as SQLi being one of the oldest web application vulnerabilities, it also can be the most damaging.


------

What is a database?

A database is a way of electronically storing collections of data in an organised manner. A database is controlled by a DBMS which is an acronym for  Database Management System, DBMS's fall into two camps Relational or Non-Relational,

DBMS i.e database management system is used to manage diff. databases in on server 

each database has table i.e a grid of row and columns 

columns have unique name in each table . 

When creating a column, you also set the type of data it will contain, common ones being integer (numbers), strings (standard text) or dates

Rows:

Rows or records are what contains the individual lines of data. When you add data to the table, a new row/record is created, and when you delete data, a row/record is removed.

Relational Database :- 

The tables will often contain a column that has a unique ID (primary key) which will then be used in other tables to reference it and cause a relationship between the tables, hence the name relational database.

Non-Relational Database :- 

Non-relational databases sometimes called NoSQL on the other hand is any sort of database that doesn't use tables, columns and rows to store the data, a specific database layout doesn't need to be constructed so each row of data can contain different information which can give more flexibility over a relational database.  Some popular databases of this type are MongoDB, Cassandra and ElasticSearch.

--------------

SQL (Structured Query Language) is a feature-rich language used for querying databases, these SQL queries are better referred to as statements.

Statements with examples :- 

1. SELECT
The first query type we'll learn is the SELECT query used to retrieve data from the database. 

 
select * from users;

The first-word SELECT tells the database we want to retrieve some data, the * tells the database we want to receive back all columns from the table. 

LIMIT 1" clause forces the database only to return one row of data

we're going to utilise the where clause; this is how we can finely pick out the exact data we require by returning data that matches our specific clauses:

select * from users where username='admin';  # use username != 'admin' which means not equal to 

This will only return the rows where the username is either equal to admin or jon. 
[select * from users where username='admin' or username='jon';]

This will only return the rows where the username is equal to admin, and the password is equal to p4ssword.
[select * from users where username='admin' and password='p4ssword';]

This returns any rows with username beginning with the letter a.
[select * from users where username like 'a%';]

This returns any rows with username ending with the letter n.
[select * from users where username like '%n';]

2. UNION

The UNION statement combines the results of two or more SELECT statements to retrieve data from either single or multiple tables; 

some rules to use UNION statement :- same number of columns in each select statement

* columns have to be of similar data type 

* columns order has to be same 

3. INSERT

The INSERT statement tells the database we wish to insert a new row of data into the table. "into users" tells the database which table we wish to insert the data into, "(username,password)" provides the columns we are providing data for and then "values ('bob','password');" provides the data for the previously specified columns.

[insert into users (username,password) values ('bob','password123');]

4. UPDATE

The UPDATE statement tells the database we wish to update one or more rows of data within a table

[update users SET username='root',password='pass123' where username='admin';]

5. DELETE

The DELETE statement tells the database we wish to delete one or more rows of data

[delete from users where username='martin';]

we can also use LIMIT clause to delete several rows 

---------

What is SQL Injection?
The point wherein a web application using SQL can turn into SQL Injection is when user-provided data gets included in the SQL query.

types of SQL injections :- 

In-Band SQL Injection

In-Band SQL Injection is the easiest type to detect and exploit; In-Band just refers to the same method of communication being used to exploit the vulnerability and also receive the results, for example, discovering an SQL Injection vulnerability on a website page and then being able to extract data from the database to the same page.



Error-Based SQL Injection
This type of SQL Injection is the most useful for easily obtaining information about the database structure as error messages from the database are printed directly to the browser screen. This can often be used to enumerate a whole database. 



Union-Based SQL Injection
This type of Injection utilises the SQL UNION operator alongside a SELECT statement to return additional results to the page. This method is the most common way of extracting large amounts of data via an SQL Injection vulnerability.

---------------

Blind SQLi

Unlike In-Band SQL injection, where we can see the results of our attack directly on the screen, blind SQLi is when we get little to no feedback to confirm whether our injected queries were, in fact, successful or not, this is because the error messages have been disabled, but the injection still works regardless

Authentication Bypass

One of the most straightforward Blind SQL Injection techniques is when bypassing authentication methods such as login forms. In this instance, we aren't that interested in retrieving data from the database; We just want to get past the login. 

----------

Boolean Based

Boolean based SQL Injection refers to the response we receive back from our injection attempts which could be a true/false, yes/no, on/off, 1/0 or any response which can only ever have two outcomes. That outcome confirms to us that our SQL Injection payload was either successful or not. On the first inspection, you may feel like this limited response can't provide much information. Still, in fact, with just these two responses, it's possible to enumerate a whole database structure and contents.


--------------

Time-Based



A time-based blind SQL Injection is very similar to the above Boolean based, in that the same requests are sent, but there is no visual indicator of your queries being wrong or right this time. Instead, your indicator of a correct query is based on the time the query takes to complete. This time delay is introduced by using built-in methods such as SLEEP(x) alongside the UNION statement. The SLEEP() method will only ever get executed upon a successful UNION SELECT statement. 

--------

Remediation 

Prepared Statements (With Parameterized Queries):

In a prepared query, the first thing a developer writes is the SQL query and then any user inputs are added as a parameter afterwards. Writing prepared statements ensures that the SQL code structure doesn't change and the database can distinguish between the query and the data. As a benefit, it also makes your code look a lot cleaner and easier to read.



Input Validation:

Input validation can go a long way to protecting what gets put into an SQL query. Employing an allow list can restrict input to only certain strings, or a string replacement method in the programming language can filter the characters you wish to allow or disallow. 



Escaping User Input:

Allowing user input containing characters such as ' " $ \ can cause SQL Queries to break or, even worse, as we've learnt, open them up for injection attacks. Escaping user input is the method of prepending a backslash (\) to these characters, which then causes them to be parsed just as a regular string and not a special character.


--------------

