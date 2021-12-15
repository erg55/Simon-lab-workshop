# Homework I

### Shell commands

We are going to use various shell commands to manipulate two text files that correspond to the word counts of the Origin of Species and all the lyrics Fall Out Boy's From Under the Cork Tree. This should allow us to answer various bizarre questions!  

I am going to be intentionally somewhat vague....remember you can use the --help flag for most commands to help learn more. Also google is always helpful. Let me know if you get stuck! The bonus questions are pretty challenging to answer with shell commands alone and no scripts. Good luck!

Use **wget** to download the files

``` 
wget https://raw.githubusercontent.com/erg55/Simon-lab-workshop/master/homework/FOBwordtable.csv
```
Or you can use **git clone** to download a whole github repository.

``` 
module load git
git clone https://github.com/erg55/Simon-lab-workshop.git
``` 
#### Ok let's start with Darwin's words:

Use the command **grep** to search through a file. **wc** may be helpful too.. 

#### 1. How many times does the word "evolve" appear? "Galapagos"? "Beetle"? How about words with "evol" in them?



Remember **head** can be modified to give the N first lines of a file. That can be piped to tail. 
#### 2. What's the 248th most common word?




Play around with **cut, sort, uniq** to manipulate the files. Remember you can use \> to write the output to a new file.

#### 3. What is alphabetically the first word used? The last word? 



#### 4. Use uniq -c on the first column to create a histogram of word usage counts. How many words are used only once? 



The following command will add the number of characters contained in a line to the beginning of the line for a given file.
``` 
awk '{ print length, $0 }' file 
``` 
#### 5. Using this, can you tell me the longest two words that appears in the Origin of Species?



Let's use the **diff** and **comm** commands to compare the two word lists. We first should only work with the word column so cut that for each file before proceeding.

#### 6. What's the 50th word alphabetically that is in both the Origin of Species and the lyrics? 


## BONUS


##### 7. How many words in the origin of species?.....


##### 8. What's the 10th common word in the lyrics that also appears in the Origin of Species? Vice versa? 








# Homework II 

Let's try and download some data from the [Short Read Archive](https://www.ncbi.nlm.nih.gov/sra/?term=Cicadidae) on GenBank. 

Replace the SRA number in the file with your specific number:  
Eric: ERR073022  
Jason: SRR7014898  
Mark: SRR7014900  
Diler: SRR7014887  
Jefrin: SRR7014891  
Katie: SRR6282309 (Chrysoperla)

```
module load sratoolkit
fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files SRAnumber
```

Run fastqc on these files. 

##### 1. Were any problems noted by fastqc? 

Go through all the other steps of assembly. You may need to create and submit sbatch scripts for this to finish within a reasonable time. You can try and combine all steps into one script or split them up into several. Frequently, you may encounter a small error in one step that prevents the completion of another. 

##### 2. What is the N50 of this assembly? What is the longest contig and what organism does it most likely originate from? 


##### 3. What is the average %GC content?


##### 4. Can you recover the COI sequence of this cicada from this assembly? Are you able to identify any bacteria present? How about other organisms? 





# Trinity stuff 

Biggest Asopinae transcriptome data on SRA [SRR11658068](https://www.ncbi.nlm.nih.gov/sra/SRX8218988[accn])

Replace the --left and --right with your forward and reverse read names.

```
module load sratoolkit
fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files SRR11658068
module load trinity
Trinity --seqType fq --left SRR11658068_1.fastq --right SRR11658068_2.fastq --CPU 20 --max_memory 150G 
```



# Homework for bioinformatics group 

We have some different skill levels so this will be a little hard to make nice for everyone but I will try. Googling hopefully will be able to help you! 


I was thinking we could do some basic summarizing of our alignment files. Probably it is easiest to do this using basic bash commands but if you want to try it in python or another langauge you should go for it. We should all be able to compare codes and see if they differ in any way. 

Make sure not to overwrite any important files. I would work on maybe a subset of your files while you verify that your script or commands work and then apply them to the whole folder .....I would think the final trimmed alignments would be good to use. 


Okay so some basic tasks: 

1) For every alignment, get the total length. 

2) For every alignment, get the number of taxa represented. 

3) Across all alignments, which taxon is the least represented. 

4) Graph each taxon by the number of loci in which it is found.

5) Graph each locus by number of taxa represented. 

6) Calculate missing data for each locus **more challenging but possible!**

7) If any taxon is present twice in a locus, check to see if the these two loci do not overlap in the alignment (or basically don't overlap) and if so stitch the two ends together into a new sequence renaming appropriately  **Jason level challenging**





