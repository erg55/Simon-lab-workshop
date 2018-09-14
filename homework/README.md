Shell commands

We are going to use various shell command sto manipulate two text files that correspond to the word counts of the Origin of Species and Fall Out Boy's From Under the Cork Tree. This should allow use to answer various questions!  

USe **wget** to download the files

``` 
wget 
```
Or you can use **git clone** to dowload a whole github repository.

Play around with **cut, sort, uniq** to manipulate the files. Remember you can use \> to write the output to a new file.


Use the command **grep** to search through a file.


The following command will add the number of characters contained in a line the beginning of the line
``` 
awk '{ print length, $0 }' infile 
``` 

Using this can you tell me the longest word that appears in the origin of species



diff
