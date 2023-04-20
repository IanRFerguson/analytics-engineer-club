# Distributed Computing
## Part I
* Distributed = data sits across multiple computers
  * Data warehouses
* Single-Node = server, single computer
  * Instance SQL (MySQL, PostgreSQL)

Motivating problems...
* Lots of data to store
* More than can fit on one computer
* BIG computers are really expensive
  * Computers get disproportionately expensive, more cost-effective to use lots of smaller computers / nodes / CPUs
  * Risky if single computer is used and it goes down

* Distributed systems increase our **fault tolerance**
* A cluster == multiple computers / nodes underlying an instance
  * E.g., the way our Redshift is set up
* Scales **horizontally**
* Runs in parallel

Big-Compute
* Split the data across different nodes
* Each node executes a query against a subset of the data

High-availability Databases
* Make redundant copies of the data on different nodes
* If an individual node breaks or fails queries can still complete
* Reduces dependency on any one piece of hardware
* **Mission critical databases**

## Part II

* Query sent to leader node
* Distributes to follower / compute nodes
* Leader node aggregates results and returns to users

### CAP

CAP theorem suggests you can choose two of the following...

* Consistent - Every read receives the most recent write (no stale data)
* Available - Every request receives a response
* Partition tolerant - The db is resilient to network outages

Some consider this tradeoff too simplistic ... the choice is **really** between speed / latency and consistency (stale data early, or accurate data later)

## Part III

Consensus - what *is* truth anyway?

We want to reach agreement with faulty communication channels ... discrepancies crop up when nodes fall out of sync

### Two generals problem

*How to coordinate action with faulty communication channel?*

1. Marcus sends a message to Scipio saying "we attack tonight"
2. Scipio will send a message back confirming he received the message

What happens if the return messenger gets caught, Scipio attacks and Marcus doesn't! <mark>There is **no solution** to this problem</mark>

In the context of distributed databases, the two generals are like two nodes trying to reach consesnus. They can't be sure that the other node is in sync. There are situations where it's **impossible** for nodes to sync with one another reliably.

*Why not just timestamps?* Clocks on different nodes may not be in sync!

Real solution is electing a **leader** node to coordinate the log, have nodes reach conesnsus on which node is the leader

### Raft & Paxos

Two famous algorithms for reaching consensus in a distributed system (very complex). Rounds of elections / voting to determine a leader node.