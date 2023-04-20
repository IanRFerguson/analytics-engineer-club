# Analytical vs. Transactional Databases

## Analytical DBs

* Usually used by data scientists, analysts
* Executing queries against the DB and analyzing offline
* Care about accessing data efficiently, usually for creating aggregates
  * Average order value
  * Trends at a state or temporal level

* These are typically **read only** as far as the user is concerned


## Transactional DBs

* Used by software engineers
* Request speed in an application
* "State" of one object at a time ... one user, one order, etc.
* **Create Read Update Delete** == CRUD
  * One data one object at time

* Must be adept at managing throughput + tons of volume

# Row Store vs. Column Store

* We want to make our databases FAST
* We want to either optimize for **analtyical** or **transactional** databases

## Row Store

* Writing one row at a time to the database
* Each person's data is most likely going to be stored in the **same relative location** locally

<mark>More efficient for transactional databases</mark>


## Column Store

* E.g., all IDs, then all names, then all states, etc.
* Less likely that each relation's data exists in the same memory location
* Allows for **efficient compression** ... important when you have a high volume of data

<mark>More efficient for analytical databases</mark>


# Massively Parallel Processing

* Certain types of queries can be sped up by processing **in parallel**
  * Breaking the tasks up into chunks that can be done at the same time

* Break the table into different sections
* Have each processor take one section
* *n* times faster than linear computation, where *n* is the number of splits / parallel processors