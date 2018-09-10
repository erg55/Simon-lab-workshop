# Simon-lab-workshop
Learning! 


BASICS

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

If you want to read more information or look at the options you can use with various shell commans try running the command with the double flag --help:

```
    head --help
```
So if you just wanted the first line of each our yours files you could run: 
```
    zcat P0075* | head -1
```
There are many other commonly used commands in bash, here are some of other most used ones. Try them out!

ls prints out all the contents of the folder you're in or that you list.

gunzip will unzip a file.

cat will print out the contents of an unzipped file.

du, disk utility, will tell you the size of a file.

touch will create a blank text document of the name you give it.

nano will allow you to edit or create a text document based on the name you give.

pwd will print your current working directory. 

EASTER EGG 

Let's do something so we barely every have to use that command. Go up one folder to your home directory: 
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
Go into that file with nano:
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
Now you can where you are all the time! Neat! 

/EASTER EGG

PLAYING WITH DATA




Tools:
[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/),
[BBmap](https://sourceforge.net/projects/bbmap/)
