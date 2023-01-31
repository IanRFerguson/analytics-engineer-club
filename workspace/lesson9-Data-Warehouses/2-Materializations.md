# Materializations

## Tables

Contains data that is physically stored on the disk somewhere. When a query references a table, the database goes to that table, reads the data off the disk into memory, and returns the data to the user

## Views

Instead of writing the data to a disk, with a view the database stores a certain query internally that it runs every time you reference the view