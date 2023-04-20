# Indexing

* Used to make queries go faster
* Use with caution!
  * Take up space in the database
  * Make other operations run slower

## Book Index Analogy

* You have a dense book with thousands of pages
* If the book has an index, find the topic you're looking for and jump to the correct page
  * In this case topics are ordered alphabetically
  * We use a **binary search algorithm** to zero-in on your target
  * E.g., you want the letter K, you land on D and know you haven't gone far enough

## In Practice

* Index creates a separate table 
* An index shows where to find the right row in the **original table**
* Putting indexes on everything will slow EVERYTHING down
  * Extra space in the DB can be costly
  * Updating indexes slows down updates