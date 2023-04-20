# Databases & SQL

* DBs save information durably over time
* Oragnized in convenient ways
* Easily extract data for use by software
* **DBMS** == Database Management Systems

## Types of DBs

* Analytical vs. Transactional
  * Analyzing large amounts of data, answering buisness questions [Redshift, Showflake, etc.]
  * Managing state for software applications [PostgreSQL, MySQL]
* Relational vs. Non-Relational
  * Data stored in independent tables, can be joined together [MySQL, Redshift, BigQuery]
  * Data stored in "documents" without fixed schema [MongoDB, Redis]
* Distrubted vs. Single-Node
  * Data are distributed across multiple computers that make up the database [Google Spanner, Azure Cosmos]
  * All data stored together on a server [MySQL]
* In-Memory vs. On-Disk
  * RAM vs. permanent hard-drive storage
  * Redis vs. MySQL

## SQL

* Structured Query Language
* Interacting with Databases
* Declarative ... you describe to the DB what you want the output to look like
* 90% of SQL is standard between databases
  * You can't plug in MySQL sql 1-1 into PostgreSQL, for example