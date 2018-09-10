# Simon-lab-workshop


Today, I would like for all of us to get a handle on the basics of working and navigating on the UConn cluster as well as working with NextGen sequencing data and familiarity with some of the commonly used tools. I think each of us should work on a single dataset at first and then maybe today or next week, we will be able to get some of the raw reads assembled and can start actually doing stuff with those files. 

### Table of Contents
* [Basics](https://github.com/erg55/Simon-lab-workshop/blob/master/README.md#basics)  
* [Cluster Things](https://github.com/erg55/Simon-lab-workshop/blob/master/README.md#cluster-things)  
* [Playing with sequence data](https://github.com/erg55/Simon-lab-workshop/blob/master/README.md#playing-with-sequence-data)
* [Tool](https://github.com/erg55/Simon-lab-workshop/blob/master/README.md#tools)
## BASICS

Let's start with logging into the cluster: 
```
    ssh USERNAME@xanadu-submit-ext.cam.uchc.edu
```

Enter your password. 

Next, create a working directory:
```
    mkdir ThursdayFun
```
Navigate into the working directory...try using tab to autocomplete your suggestions after typing a capital "T":
```
    cd ThursdayFun
```
Now lets copy some data files from my folder (which has had it's permission modified so others can access it) into your current folder...let's try these three samples P0075_CS_I27897_S125, P0075_CS_I27898_S126 and P0075_CS_I27899_S127.
```
    cp /home/CAM/egordon/Dropbox/P0075_CS_I27897_S125_L001_R1_001.fastq.gz .
```
```
    cp /home/CAM/egordon/Dropbox/P0075_CS_I27897_S125_L001_R2_001.fastq.gz .
```
You could also use the wildcard to match anything and copy all matching files at once. 
```
    cp /home/CAM/egordon/Dropbox/P0075_CS_I27897_S125_L001* .
```
Use head to look into the files you downloaded:
```
    head P0075* 
```

Oops they are still zipped, Press Control+C to interrupt a command.

Instead you can try use zcat to print the file and then pass it to the head command with the "|" symbol:
```
    zcat P0075* | head
```

That's what fastq files look like! Neat!

In the future, if you want to work with these files you can point to their path in my folder and work with them the same way as if they were in your current folder. Doing this will make sure we are not wasting too much storage space on the cluster. 

If you want to read more information or look at the options you can use with various shell commans try running the command with the double flag --help:

```
    head --help
```
So if you just wanted the first line of each our yours files you could run: 
```
    zcat P0075* | head -1
```
There are many other commonly used commands in bash, here are some of other most used ones. Try them out!

**ls** prints out all the contents of the folder you're in or that you list.

**gunzip** will unzip a file.

**cat**, short for concatenate, will print out the contents of an unzipped file.

**du**, disk utility, will tell you the size of a file.

**touch** will create a blank text document of the name you give it.

**nano** will allow you to edit or create a text document based on the name you give.

**pwd** will Print your current Working Directory. 

#### EASTER EGG 

Let's do something so we barely every have to use that **pwd** command. Go up one folder to your home directory: 
```
    cd ..
```
or
```
    cd ~
```
or just
```
    cd 
```
Create a hidden file called .bash_profile: 
```
    touch .bash_profile
```
Go into that file with **nano**:
```
    nano .bash_profile
```
And paste the following into the file: 
```
    export PS1="username@xanadu-submit-ext.cam.uchc.edu:  \w:"
```
Exit with control+X, then "Y"

Log out of and then back into the cluster:
```
    exit
    ssh USERNAME@xanadu-submit-ext.cam.uchc.edu
```
Now you can see where you are all the time! Neat! 

## CLUSTER THINGS

One of the benefits of using the cluster is that commonly used programs are already installed on it and thus easy to use. To activate the commands associated with these programs use **module load** and the program name. You can use tab to see all the programs available. Try typing:

```
    module load b
```
And use tab to see all the programs starting with the lowercase letter "b" already installed. Let's activate blast:

```
    module load blast
```
Now if we type blastn --help we can see how to use this command:
```
    blastn --help
```
Before loading this module this wouldn't have worked. 

The other more major benefit of the cluster is the ability to use the large amounts of computing resources to speed up complex computing tasks. To use these resources, you must submit a script that specifies certain things in a standard way. Below is an example of the first several lines needed in a script with annotations. 

```
#!/bin/bash
#This specifies this script should be read as a bash script as opposed to some other language

#SBATCH --job-name=trinity
#This is the name given to the job for your own reference later

#SBATCH -N 1
#This refers to the number of nodes you want for your job. Almost always 1 is appropriate. To expand a job across more than one node, you generally need to incorporate a multi-threading program like MPI and often the amount of speed gained is not worth the effort. This program is hard to use. 

#SBATCH -n 1
#I don't know what this does....let's look it up....

#SBATCH -c 30
#This is the number of processors you want for the job. The more you devote the faster the job will run...but sometimes it can be harder to get the resources to run a job if you request too much.  

#SBATCH --mem=200G
This is the amount of memory you need for the job. Assemblers often require a high amount of memory. 

#SBATCH --partition=general
#This is the partition you want to submit a job too. They are several partitions where the nodes have a different amount of memory and processors. 

#SBATCH --qos=general
#This was newly added....not sure exactly why but you need it now

#SBATCH --mail-type=END
#This says to send you an email when the job is finished.

#SBATCH --mail-user=email@uconn.edu
#Email address

#SBATCH -o myscript_%j.out
#This is the file name created from the standard output of the job in the folder in which you ran the script.

#SBATCH -e myscript_%j.err
#This is the file name created from the standard error of the job in the folder in which you ran the script.

```
Much more information about the Xanadu resource can be found online [here](https://bioinformatics.uconn.edu/resources-and-events/tutorials-2/xanadu/)

Create a script named test.sh with the following text using **nano test.sh**:

```
#!/bin/bash
#SBATCH --job-name=test
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=END
#SBATCH --mem=1G
#SBATCH --mail-user=email@uconn.edu
#SBATCH -o myscript_%j.out
#SBATCH -e myscript_%j.err
echo "Hello World!"
```
Now you can use **sbatch script.sh** to submit the script:
```
    sbatch script.sh
```
Use **squeue** to check the status of the job requesting jobs run by only your username:
```
    squeue -u USERNAME
```
Or you can look at all the jobs running or in line to run:
```
    squeue
```


```
    sinfo -s
```

## PLAYING WITH SEQUENCE DATA

Some of the seuqnece data has been artifically split up into smaller files. Let's combine them before assembly:
```
    sinfo -s
```

```
fastqc
```
Download the fastqc file
```
    rsync
```
Deduplication
```
clumpify.sh in1=$x'R1_001.fastq.gz' in2=$x'R2_001.fastq.gz' out1='dedup'$x'R1.fastq.gz', out2='dedup'$x'R2.fastq.gz' dedupe;
```
Trimming
```
trimmomatic-0.36.jar PE -phred33 'dedup'$x'R1.fastq.gz,' 'dedup'$x'R2.fastq.gz' $x'_forward_paired.fq.gz' $x'_forward_unpaired.fq.gz' $x'_reverse_paired.fq.gz' $x'_reverse_unpaired.fq.gz' ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:50;
```
Merging
```
bbmerge.sh in1=$x'_forward_paired.fq.gz' in2=$x'_reverse_paired.fq.gz' out=$x'merged.fq.gz' outu1=$x'unmergedF.fq.gz' outu2=$x'unmergedR.fq.gz'
```
Combine all files for spades
```
cat $x'unmergedF.fq.gz' $x'unmergedR.fq.gz' $x'_forward_unpaired.fq.gz' $x'_reverse_unpaired.fq.gz' > $x'allsinglereadscombined.fq.gz'
```
Run spades
```
/home/CAM/egordon/spades/SPAdes-3.12.0-Linux/bin/spades.py -t 20 --merged $x'merged.fq.gz' -s $x'allsinglereadscombined.fq.gz' -o $x'trimmedspades.assembly/'
```




#### Tools:  
[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)  
[BLAST](https://www.ncbi.nlm.nih.gov/books/NBK279690/)  
[BBmap](https://sourceforge.net/projects/bbmap/)  
[Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)  
[Spades](http://spades.bioinf.spbau.ru/release3.9.0/manual.html)
