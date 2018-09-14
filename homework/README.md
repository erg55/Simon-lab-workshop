### Shell commands

We are going to use various shell commands to manipulate two text files that correspond to the word counts of the Origin of Species and all the lyrics Fall Out Boy's From Under the Cork Tree. This should allow us to answer various bizarre questions!  

Use **wget** to download the files

``` 
wget https://raw.githubusercontent.com/erg55/Simon-lab-workshop/master/homework/FOBwordtable.csv
```
Or you can use **git clone** to download a whole github repository.

``` 
module load git
git clone https://github.com/erg55/Simon-lab-workshop.git
``` 
Use the command **grep** to search through a file.

#### 1. How many times does the word evolve appear? Galapagos? Beetle?



Remember **head** can be modified to give the N first lines of a file. That can be piped to tail. 
#### What's the 248th most common word?




Play around with **cut, sort, uniq** to manipulate the files. Remember you can use \> to write the output to a new file.

#### 2. What is alphabetically the first word used? The last word? 



#### 3. Use uniq -c on the first column to create a histogram of word usage counts. How many words are used only once? 



The following command will add the number of characters contained in a line the beginning of the line
``` 
awk '{ print length, $0 }' file 
``` 
#### 4. Using this can you tell me the longest two words that appears in the Origin of Species?



Let's use the **diff** command to compare the two word lists. We first should only work with the word column so cut that for each file before proceeding. 

#### 5. What's the 50th word alphabetically that is in both the Origin of Species and the lyrics? 





Loop.
