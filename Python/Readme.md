
If you don't know anything about coding then this might be nothing more than copying and pasting code.

So I will quickly explain:


```python
a = 10
print("a is a number equal to:", a)

a = "Nguyen"
print("a is now a string which returns:", a)

a = [1,2,3,"cat","5","meow",7]
print("a is now list which returns:", a)
```

    a is a number equal to: 10
    a is now a string which returns: Nguyen
    a is now list which returns: [1, 2, 3, 'cat', '5', 'meow', 7]


For loops can execute a task a set number of times.
They can also be used to pull out every item in a list (or other structure) one at a time. 
In this example, I use the list we defined in the previous section. The loop starts at the first variable in the list, then moves on to the next piece of indented code. The if statement checks whether or not that value is an integer, then prints something depending on the result. After that, the code block is repeated using the second value in list a.

Notice that i gets assigned to the value of the object in the list every loop.


```python
b = 0
for i in a:
    if type(i) is int:
        b += i
        print(i, "is an integer")
    else:
        print(i, "is not an integer")
print("The sum of all integers in the list is", b)  
```

    1 is an integer
    2 is an integer
    3 is an integer
    cat is not an integer
    5 is not an integer
    meow is not an integer
    7 is an integer
    The sum of all integers in the list is 13


Integers, strings, and lists are basic types of objects that you will always use, but there can be any type of objects. Many python modules will have their own types of objects with unique data structures. 


Objects are acted on by methods, and they will output another object (usually). You can assign those objects to variables and send them into other methods.

# Biopython

Biopython is a massive python module designed for bioinformatics!

   **Note on Biopython in the cluster and version control**
The cluster has a few random versions of python to choose from, and the packages within them are maintained by someone else. As a result, only one of them has BioPython installed: python/2.7.8

You can develop scripts for this version of python, but biopython is very out of date and you can't use the 'qblast()' function, nor 'Entrez.read()', and probably some others that I haven't tried. The best way around this is to install your own updated version of python in a virtual environment, which lets you add your own packages!

After logging into the cluster:

    module unload python
    module load python/3.6.3
    virtualenv py-3.6.3
    module unload python

This creates a directory with a new python in it. Activate by running the activate file 

    source /py-3.6.3/bin/activate
    
When you're in the virtual environment, you can install new packages using `pip`

    pip install biopython
    
    
To exit the virtual environment type

    deactivate
    
    
Our lab has started a group virtual environment so we can all have the same package base. You can activate it with

    source /UCHC/LABS/Simon/venv/py-3.6.3/bin/activate
    
   or if that part of the cluster is down again use mine:
   
    source /home/CAM/jvailionis/venv/py-3.6.3/bin/activate
   
   (or make your own, it's easy)

### Reading fasta files in python using SeqIO
   The SeqIO module is designed for handling fasta files. There are two methods to read fasta files with this module


```python
from Bio import SeqIO
```

   SeqIO.parse() generates an object with two important components: 'seq' and 'id'


```python
for sequence in SeqIO.parse("/UCHC/LABS/Simon/Python_Test/mystery.fasta", "fasta"):
    print("Name:", sequence.id)
    print("Sequence:", sequence.seq)
```

    Name: Uninformative_Sequence_Name_1
    Sequence: AAACACACCTACCGTACAACAGCCGATACAGACGATACTACACAACAGCTTAAATTTGCGGATAATGAACAAGAGAACCCAATACAGTTCTTGAAGCATATGGAAATGAATATGGAAGCAATTTTATGATGCGATAAACGATAGTGAAAAAATAAATTGGATTAGCTGTCATCATAAGGGACCGCATCAGATTGGTTTTCGGTCATTCAAGATAAAGTGTAACCTTAAATCCAAAATGATGAAGAGAAGAGAAATGAAACTTTCATTGTCGAAAAAGACAAATTATAATAAATGTTCTTCCAATAATAACATGAATTCCGTGGAATCCTGTTGCCATGAAAAATGTTGATCCATAAATTGAATCAGAAATACAAAATGGGGATTCATAATATTCATATCCTTGCAAAATAGTGAAATATACACCTAACAATAAAGTCAATATAATTCTATAAATAGATTCATCATATTTTTTTTCTATAATCGAATGGTGAGCTCAAGTAATAGTTACACCAGAACATAATAAAATTATAGTATTTAATAATGGAACATGTATTGGATTAAATGGCTTAATACCGGCAGGAGGTCAAATTATTCCAATTTCTATAACGGGTCTTAATCTTCTATGAAAAAATCCCCAAAAAAAAGAAATAAAAAAAAAAATTTCTGAAATAATAAATAATACTATTCCAATCCTTAAACCCCTTACAACCGTGACTGTGTGTAATCCTAAAAACGTTCCTTCTCGTGAGATATCACGTCATCATTGAATTATTGTTAAAATTAAAATTAAAAATCCAATAATTAATAAAATAAAACTATATATATGAAATATTTTTACTATTCCAGATACAAAAGTAAGTGCTCCAATAGACCCAGTTAAAGGTCAAGGTCTATAATCAACTAAATGAAAAGGGTGGTTATTCATAAGAAATTTCTCTATAATATAAAGTGCTAAGAACTGTAAAAACATATGATTGAATTAAAGAAACAGCCGATTCAAACATTATTAATATAATTTGAATGAAAATAATTAAATATGTGCATATTCTTATATTAATTGAACTATTTCCTAATAATGTTATCAATAAATGACCTGCAATTATATTAGCTGTTAAGCGAACAGCTAATGATCCAGGTCGAATTATATTTCTAATTGTTTCAATACATACTATAAATGGTATTAAAACAGTAGGAGTTCCCATTGGAACTAAATGACAAAATATATGATTAGCATTATTTAAAAATCCAAATAAAATAAAAGTCATTCATAATGGCAAAGCCAATCTAATTGTAAATGTTAAATGACTTGATCTAGTAAAAATATATGGAAACAATCCAAGAAAATTATTTAATATAATAAATATAAATAAAGAACAAAATAATAAAGATCTTCCTAAAGATCTTTTTCCCATTAATATATTCAATTCAAGTCTTAAAGTGTTTAAAATTTTGATTAAAGTTATTAATCTTCGATTAGGAACCACTCAATATACTAAAGGAATAAAATATATTAAAGATGAAGATCTAATTCAATTAAATGAAAACATACCTGTTGATGGATCAAATGTCGAAAATAAATTTCCTATCATATTCAGTTAATTGTTTTAATTAAATTATTAGATAATTTAATCTTAGGTATAACCAAAAATGAAAAATAAATTACAGTCATAATTAATAAAATAATTATAATAAAATAAAAAAATAAAATTACTCAATTTATTGGAGATATTTGAGGAATGGAAAAATACTATTTAAGTTTCATTATTCTGACAGAATAATATTTTATATAAAATAATTTTTCCATTAAGAGTAATCGTTAATTACTATAAATTGGTTTAAGAGACCATTACTGACTTTCAGTCACTTAATGAACAATTAATTAACCAATTAATAAAATATTTTGAGCTAACTCTTTCAATAACAATGGGTATAAATCTATGATTTGCGCCACAGATTTCTGAACATTGCCCATAAGATAATCCTGGTCGACTTATAAACATTCTGGCTTGATTTAATCGACCAGGGACTGCATCCACTTTCACTCTCATAGAAGGCATAGCTCATGAATGAATAACATCAAAAGATGAAATCAATAAACGAATTTGAGTATTGAATGGTAAAACTGTTCGATTATCCACATCTAATAAACGAAATTCACCTATCAATAATTCATTATATGATTTTATATATGAATCAAATTCAATTATCATAAAATCCGAATATTCATAAGATCAATATCATTGATGACCAATAATTTTTAAAGTTATTAAAGGCTTTCTAACTTCATCGAGTAAATAAAGTAATCGTAAGGATGGAAATGCAATAAAGACTAAAGTCAAAGCAGGAAGAAAAGTTCAAAAAAATTCAATTATTTGTCCTTCTAATAATAATCGATTAACAGTAGTATTAAAAATTAATATTACTATCATATAAGCAACAATGGAAGTAATAACAATCAAGATAATTAAGGTATGATCATGAAAAAATATTAATTGTTCTATTAATGGAGATATAGCATCTTGTATATTAATATATGACCAATTGCAAATTTCTAATAAAAAAATTATTTTATATATGAATCTTAAATTCATTGCACTTATTCTGCCATATTAGAATTGAATTAATATGGGAATTTCTCTATATGAATGTTCTGAGGGGGGATATTTTTGTAATCATTCAATTGATGATATTATATTATTTGAATATAAAATTTTTCGTTGTGAAATAAATCTTTCCCACACAATAAATAACAATAATAAAATTCCAATTAATGAAATTCTTCTTCCAATAGAAGATAACACATTTCATGATATATAAGCATCTGGATAATCTGAATATCGACGAGGTATTCCACTAAGTCCCAAAAAATGTTGAGGAAAAAAAGTTATATTCACACCAATAAATATAACAATAAAATGAACCCTTAATCAATTAGAATTTAATGATATCCCAGTAAATAATGGATATCAATGAATAAATCTACCTAAAATTGCAAACACTGCACCTATGGATAAAACATAATGAAAATGTGCTACCACATAATATGTATCATGTAAAACAATATCAATAGATGAATTAGCTAAAATTACACCTGTTAATCCTCCAATAGTAAATAAAAACACAAATCCTAATGCTCATAAAATAGAAGGTGAGATCTTAATTTTAGTTCCTCTAAGAGTTGCTAATCAACTAAAAACTTTAATTCCAGTAGGAACAGCAATAATTATTGTTGCTGATGTAAAGTATGCACGAGTATCAACGTCCATTCCAACGGTAAATATATGATGAGCCCAGACAACAAAACCTAAAATTCCAATAGATATTATTGCATAAATTATTCCCAATGACCCAAATGACTCAACCTTTCCTCTTTCTTGAGTAATAATATGTGAAATTAACCCAAATCCTGGTAAAATCAAAATATAAACTTCAGGATGACCAAAGAATCAAAATAAATGCTGATATAAAATGGGATCCCCCCCTCCTGAAGGATCAAAAAAGGAAGTGTTTAAATTACGATCAGTCAATAATATTGTAATAGCTCCTGCTAAAACAGGTAGGGATAATAATAACAAAAAAGCAGTGATTAAAACTGCTCAAACAAATAATGGTATACGATCCATGAAAATTCCGACTGAACGTATATTAAAAATTGTTCTAATAAAATTTACCGCACCTAAGATCGATCTTGCACCTGCAAGATGAAGAGAAAAAATAGTTAAATCAACACAAGAACCCGAGTGCGCAACACTACTCGATAAAGGTGGGTATACCGTTCATCCAGTACCAGCACCTCTATCAACTATTCTCCCAATTAATAAAAGTGTCAAAGAAGGTGGTAGTAATCAAAAACTTATATTATTTATACGTGGAAAAGCTATATCTGGAGCCCCAATTATTAAAGGAACTAATCAATTTCCAAATCCACCAATTATAATAGGTATAACTATAAAGAAAATTATAATAAAAGCATGGGCAGTGACAATAACATTATAAATTTGATCATCTCCAATAAATGATCCAGGAATTCCTAACTCAACACGAATTAAAACTCTCAAAGTTGTACCAATTATTCCTGACCAAATTCCAAAAATAAAATATAATGTACCAATATCTTTATGATTAGTTGAAAAAAACCATTTATTCATAATCATAATTTTATTGGGATGGCTGATAAAAGCAATAAATTGTAAATTTATTAATGAAAATAATATTCTCCCAATAGTGAGTCTTATATTTAATTATAATATTAAATTGCAAATTTAAAGGTGATTTAAAGTAAATCTAAGGCTTATAATAATTATATTTTTAACTTTGAAGGATAATAGTTTCTTTAACTTAAAACCTTAATTACCAACAGTAAGTAAAGAAATTCTCATCAATCCAATTAATAAAAATCTACCCAAATAAATTAATCTATTCATCTTAATAAATAATATCTTTATTGTAACTATATTTATTATTAACCCAGTTATTACAATGCGTAAATAATAAAACAAAACCAACAATGCTGTTATTAATATCATTAAACACAATATGTATATATTATTAATTAAAAGACAATAAATTATTATAAATTTAGGAAAAAAACCAAAGAATGGTGGTAACCCACCTATTGATAAGAAAACAATTATTACCAAAAAAGTCTTAATTTTGTTCCCAAATATTAAGAAGAATTGATTTAAATAGTTTAAATTATTTATATCCAATAAATAACAAATTAAATATAAAGAAAATGAATAAATTAAAAAGTAAATTAATCAAGAATAATTCATTATCATAACTCCCACAAAAATTCATCTTAAATTATAAATTGAAGAGTATGCTAAAATTTTTCGAAACGAAGAGTAACATAGACCACCTAATGAACCCCATAAACAAGAAAAAATAATAAATATAATTAATCTTATATCAATATAACTCAATAAAACTAAAGGAATAATTTTTTGAATTGTCATAATTATAAAAGAAACTATCCAAGATAGCCCATCAATTACTGAAATATATCAATAATGAAATGGAGGACAACCAATTTTAATTATTAATCTAATTATAATAAAATAGTTAAATTCTACGCATACATTTATAATAACCATTGAAAGAAATAGTAGTCTTGAACCTATTCTTTGTACAATAAAATACTTAATCATAGATTCGGAAGAATAAACTCTTATTTTGTTTAATATAAAAGGCAAAAAAGAAATTATGTTTACCTCAATTCCAATCCAACAACCCAGCCAATTGTTAGAAGAAACGGATAACATAATCCCTAATAATAAGAACGCCATAAATATTATATAAGAGGAATTTTTTTTAATTAAAAAGAGGATTTTATTTCCATAAATGAGGTATGAACCCATTAGCTTAAGTTTAGCTTATCTTTTATGTTGTAGTTTATGAAGAACATTAATTTTTGATATTAAAAGACAGTTTAATTCTGACAACATATAATAAGAGTATTATATACATAATTTATTCTATCAAAATAACCCTTTTATCAGGCATCTTATTATCTATAGCCACTACCATAATGTGTATTTTATTGATAAAATAATAGCATTAGGTGTAACGATATATCACACTGGCATAACTCATTATACTCTATCTACACGAACTTCCCTATCTATAGCCACTACCATAATGTGTATTTTATTGATAAAATAATAGCATTAGGTGTAACGATATATCACACTGGCA
    Name: Uninformative_Sequence_Name_2
    Sequence: AATTTTATTTTTTAGTAAAGATTTACTCATATTAAGATATAATTTGTGATTGGATAATATCTCATACGGATTAATTATTCTTACTGTATGAATTTCATTTTTAATAATTAATTCAAGACCAAATTATAAACATAATAATATGGATGTATTTTTATTCATAGTAATATTATTAATAATTTTATTAATTTTATCATTTTGTTCTTATAACTTAATATTATTTTATATTTTCTTTGAATCAAGATTAATTCCCACAATAATTATTATTATGGGATGGGGCTATCAACCTGAACGAGTTAATGCTAGATATTATTTATTATTTTATACTTTATTTGCATCATTTCCATTTTTAATTTCCATTATTTCATTATATATAAATAATTTAACAAATATTATGTTATTAATATATTCAAGAAATAAATTTATTTATTTAAGAATAATTTTAGCATTCATAGTGAAAGTTCCACTATTTATATTTCATTTTTGATTACCTAAAGCTCATGTTGAAGCTCCGGTTTCTGGTTCAATAATTCTAGCTGGAATTCTATTAAAATTAGGCACATATGGATTAATTCGTTTAATGTTTATTATGCCGATAATATTTAATAAATATAGATTTATTTGAATTTCAATTCCTATAATTGGAGGAATTATAATTAGATTATTATGTATAATACAAATTGATATTAAATCAATAATTGCTTATTCATCCGTTGCTCATATAGGTCTGGTTGTTGGGGGGATTATAACAATAAATACTTGAGGGTTACTAGGTTCATACTATATAATTATTGGGCATGGGCTATGTTCCTCAGCTTTGTTTTGCTTAGCTAATATTAGTTATGAACGAATGGGATCTCGCAGAATATTAATTAATAAAGGAATGTTAAGATTTATACCATCAATAACTTTAATATGATTTTTATTATCAGCAAGAAATATTTCATGTCCGCCAACAATTAGATTAGCTGGAGAGATAATAATTTTAAATAGTTTAGTGTCTTGAAATTCATTAAGCATAATATTTTTGTCTATTTCCTCTTTTCTTTCAGCTGGCTATAGATTATTTTTATATTCATATACTCAGCATGGAACATTTTTTTCAGGCTCTTATTCATTTAATTATGGAGTTGTTCGGGAGTTTTTTTTAATCATAATACATTGAATTCCGTTAAATTTTATCATTTTAAAGATAACATTATTAATTTATTCAATTAGTTTAACATAAAACATTAAATTGTGGATTTAAAAATATAAATTTATATTGGATCATGAATAATAAAATCAATATATACTTCTTCTTGATCTTGATAGTTTTAAGATTAATAATAATAATTTTATCTATAAATATAATTATTTTCGATTATGTTGTAATAATAGAATGAATAATTGTTAGAATTAATTCATGTAATATTTATATAACTATAATTTTTGATTTTATATCAACTATATTTTTATCAACAGTGATATTTATTTCATCAACAGTGATGTTTTATAGAGGTACATATATAGAGAATGATAAAAATATTAGACGATTTATTTATATTATTATAATGTTTGTAATATCAATAATTATATTAATTATTAGTCCTAATATAATTAGTATTATTGTTGGATGAGATGGACTTGGTCTTGTCTCATATTGTTTAGTAATTTATTATCAAAATTTAAATTCAGCTAATGCAGGAATATTAACCGCTTTAATAAATCGAATTGGAGACGTAATGATTTTAATATTAATTGCATGAATATTAAATTTTGGTTCTTGAAATTTTTTATCATTTATTAGTAAAATAGAAATAAATTTTATATTAATTTTTATTATTATTGCAGGGTTTACCAAAAGAGCACAGATCCCATTCTCTTCTTGACTTCCAGCAGCAATAGCTGCTCCAACACCAGTATCTGCATTAGTTCACTCATCAACATTAGTTACTGCTGGGGTATACCTAATAATCCGATTTAGAAAATTAATTCTTACATTAAATTTTATTCAGTTTTTCTTAATATTATCTATCATAACTATAATTATGTCTGGTATTGGGGCAATTTTTGAATTCGATTTAAAAAAAATTATTGCATTATCAACATTAAGACAGCTTGGGATTATGATATCAATTTTAATATTTGGTTATCCAATATTGTCATTTTTTCATCTTATTATTCATGCTTTATTTAAAGCATCTTTATTTTTATGTGCAGGTGTATTAATTCATAGATTAAATAATAATCAAGACATTCGACTTATAGGATGTATAAGTTATAATATACCCTTAACAATAATGTTAATAAATACTGCTAATTTATCATTATGTGGAATTCCATTCATAAGAGGATTTTACTCAAAAGATTTAATCATAGAAATAATATGCTCAAATCATATCAATATATGAATTATTATATTAATATATTTAGGAATTGGCTTAACATCATTTTACTCTGCTCGATTAACTTATTTTTCTATAAATATAAATTTTAATTACTATAGTTTTAATTCATTAAATGAACCATTTAATAATATACTAAAAAGTATTTTAATACTATCTATTTATTCAATTATTTCAGGATCTATAATTACATGATTAATATTTAATAATCCAATTATTATCTCTCTTCCAATAGAAGGGAAAATAATAGCTTTATTTATATCTATAATCGGATTATTAATTGGATATGAAATTTCATCATTTTCAAAAACAAAAAAGAGAATAATGAAGGAATTTCTTGGAACTATATGATTTATAAAACAAATTTCAACGTTCCATAATCAATTTTTTTTATTAAAGAATTCTTATATATATCAAAAATCAATTGATTTAGGTTGAGGAGAAAAACTAGGGGTCCAAGGATTAGTTCAATTAATTAAATTTATGATATTTATTAATATTAAAATAAGCAAGAATAATTTTAAAATTCAAATAATAGCATTTATTTTATGGATCTTAATTATATTATATTTAAATAGCTTAACAAGAGCATAATATTGAAGATATTAAGGTGATAATTATATTTTTAAATATTTATAAGACAATGCCTCTCTTTCCAATGAAAATGAAATGTTTTAAAAACTTTATAAATAAGGAAAAAACGGATTTTAACCGCTTTAAAAACCAGTTAGCAGCTGCTTTTAACCTCGTTTCCTTTTAATTGGAAATACATTCAATTACCTTATTAACAATAAAGTGCCTCTATTTTGGCTTCAATTAAAACAATGGAATATATATTCTTTTTTTAGGTCGAAACTAAATGTATTAATTACTTCATTATTACAAGAATGGTTGATAACAACACCTATTGATTGCAATTCAATTATTATAATTAAATACATCCCTCATTAAACTCAATTTAATATATTATTTATTCATTCATGATATAATCCTAAAATCAATAATAATAAAAATACCATTATAATTATATAAATTTCAATTATATTAATTGAAGATATAATGACAACAACAGGTAAAATAATAACTAATTCAACGTCAAAAATCAAAAAAATAACCGCAATTATAAAAAAATGTCTAGAAAATGGAATCCGTGAGGATTCAAACGGATCAAATCCACACTCAAATGGTGATGATTTTTCACGATCAATGATTGACTTAATAGAAATAATATATAAAATAATTATTAAGATAGATAATACAAATAATAAAATAGCAGAATATATTATAAT
    ...


Another useful method is to save all of the SeqIO objects into a list. This allows you to refer back to them later (in the for loop you can only go through each object once unless you to the whole loop again)


```python
sequence_record = list(SeqIO.parse("/UCHC/LABS/Simon/Python_Test/mystery.fasta", "fasta"))
print(sequence_record[5].id)
print(sequence_record[5].seq)
```

    Uninformative_Sequence_Name_6
    TCTGTGGCATCTGCCCATCTGTTGCAGCAACAACTAATATAGCACCATCCATCTGAGATGTCCCTGAGATCATGTTTTTAATATAATCTGCATGCCCAGGGCAATCTGTATGAGCATAATGTCTCTTCTTTGTTTTATATTCTATATGTGTAGCATTAATTGTTATGCCACGTGACTTTTCTTCTGGTGCTCTATCAATCTCACTGTATGGAATATACTTGGTCTCGTTTTCTTTTGACATCAGCTTCGTAATTGCTGCAGTAAGAGTAGTTTTTCCATGATCAACATGACCTATGGTTCCCACATTACAATGGTTTCTACTAATTTTCGTACAGTAACACCTTATCCTATCCGTGCTACGTATAAAACTGTAATTACTAGTATTTAAAACTGTTCTTGAACTTTTCACTATATTTAAATACACGACTGTATGCCTCACACATGACAAAACTATGCTGTTCATTTTCTTCAAATTCACTTCAATCCTTTATTTTTCTTGATTGGTCCCACGCCTATATAAAGACGAGAAAAGGAAGACAGGAATATTAGTGTGCTGTAATGAGACTAAGTATGTTGATATTAAAATGGAAGACGTTCTTACCAGACTGGTGGAGACAGAAAAACATGAAGTGGTATAAGAAAACAAGCCAGAATCTCAGATGAAATTAAACGCAATGTCAGAGCTAAGTCTGAT


### Automated Blast
I don't remember where these sequences came from so we are going to blast them and find out
NCBIWWW offers the qblast() function which lets you blast to the ncbi servers with any blast command.
NCBIXML lets you read in the blast object 


You can go through each of your sequences this way but it will take too long for right now. Usually you will submit something like this as a job.


```python
from Bio.Blast import NCBIWWW
from Bio.Blast import NCBIXML
```


```python
for SeqIOobject in sequence_record:
    handle = NCBIWWW.qblast("blastn", "nt", SeqIOobject.seq)
    blast_record = NCBIXML.read(handle)
    
    for alignment in blast_record.alignments:
        print(alignment.title)
        # do whatever
        
```

    gi|1406948775|gb|MG737759.1| Tryella crassa isolate TRYCRA mitochondrion, partial genome
    gi|1406948439|gb|MG737735.1| Aleeta curvicosta isolate ALECUR mitochondrion, partial genome
    gi|1406948523|gb|MG737741.1| Magicicada septendecim isolate MAGSEP mitochondrion, partial genome
    gi|1406948509|gb|MG737740.1| Magicicada neotredecim isolate MAGNEO mitochondrion, partial genome
    gi|1406948747|gb|MG737757.1| Magicicada tredecula isolate MAGTDC mitochondrion, partial genome
    gi|1406948537|gb|MG737742.1| Magicicada septendecula isolate MAGSDC mitochondrion, partial genome
    ...

```python
## Theoretically this works but I haven't tested it
fasta_file = open("/UCHC/LABS/Simon/Python_Test/mystery.fasta", "r").read()
handle = NCBIWWW.qblast("blastn", "nt", fasta_file)
blast_record_2 = NCBIXML.parse(handle)

for blast_object in blast_record_2:
    for alignment in blast_object.alignments:
        print(alignment.title)
    
```

Instead we are all going to blast one of the mystery sequences:


```python
handle = NCBIWWW.qblast("blastn", "nt", sequence_record[0].seq)
blast_record_3 = NCBIXML.read(handle)
for alignment in blast_record_3.alignments:
    for hsp in alignment.hsps:
        if hsp.expect < 0.0001:
            print(alignment.title)
            print("length:", alignment.length)
            print("e-value:", hsp.expect)
            print(hsp.identities)
            #if you want to print the whole alignment, you have to break it into chunks
            print(hsp.query[0:50], "...")
            print(hsp.match[0:50], "...")
            print(hsp.sbjct[0:50], "...")
            print()
        
```

Protein blast search. You could also use blastx for this but I wanted to share the method for translating DNA to proteins.

Protein outputs look ugly because it clumps things together for some reason


```python
def translate(sequence):
    table = 11
    min_pro_len = 100
    prolist = []

    for strand, nuc in [(+1, sequence), (-1, sequence.reverse_complement())]:
        for frame in range(3):
            length = 3 * ((len(sequence)-frame) // 3)
            for pro in nuc[frame:frame+length].translate(table).split("*"):
                prolist.append(pro)
    return(max(prolist, key=len))

#handle = NCBIWWW.qblast("blastp", "nr", translate(sequence_record[0].seq))
#blast_record_4 = NCBIXML.read(handle)
for alignment in blast_record_4.alignments:
    for hsp in alignment.hsps:
        if hsp.expect < 0.0001:
            print(alignment.title)
            print("length:", alignment.length)
            print("e-value:", hsp.expect)
            print("identities:", hsp.identities)
            print(hsp.query[0:50], "...")
            print(hsp.match[0:50], "...")
            print(hsp.sbjct[0:50], "...")
            print()
```

    gi|1406948510|gb|AWV83484.1| NADH dehydrogenase subunit 2 (mitochondrion) [Magicicada neotredecim] >gi|1406948524|gb|AWV83497.1| NADH dehydrogenase subunit 2 (mitochondrion) [Magicicada septendecim]
    length: 323
    e-value: 1.83572e-45
    identities: 78
    LIYFLIYSFSLYLICYLLDINNLNYLNQFFLIFGNKIKTFLVIIVFLSIG ...
    L+YFLIYS SL+L CYL   NN+NYLNQ F++F NKI + +++++F+S+G ...
    LVYFLIYSLSLFLTCYLFWTNNMNYLNQIFILFNNKITSLMLMVIFMSMG ...
    
    gi|676260432|gb|AIM19523.1| NADH dehydrogenase subunit 2 (mitochondrion) [Magicicada tredecim]
    length: 315
    e-value: 1.07156e-44
    identities: 76
    LIYFLIYSFSLYLICYLLDINNLNYLNQFFLIFGNKIKTFLVIIVFLSIG ...
    L+YFLIYS SL+L CYL   NN+NYLNQ F++F NKI + +++++F+S+G ...
    LVYFLIYSLSLFLTCYLFWTNNMNYLNQIFILFNNKITSLMLMVIFMSMG ...
    ...


### Blast parsing and Entrez

To make these results useful, we want the code to parse through all the hits for every sequence and choose a consensus identity. You can do this using ncbi's taxonomy database. 

Every ncbi database has a different type of accession number. The taxonomy database uses taxid's but it won't take gi numbers or gb numbers. 

We can query the gb database using the gb numbers and then extract any info we want about our sequences


```python
from Bio import Entrez
import re

Entrez.email = "jason.vailionis@uconn.edu"
tax_list = []

for alignment in blast_record_3.alignments:
    for hsp in alignment.hsps:
        if hsp.expect < 0.0001:
            gb_number = re.findall("(gb\|.*)\|", alignment.title)[0]
            handle = Entrez.efetch(db="Nucleotide", id=gb_number, retmode="xml")
            record = Entrez.read(handle)
            handle.close()
            #lineage = re.findall("'GBSeq_taxonomy': '([A-Za-z; /-]*)'", str(record))
            #organism = re.findall("'GBSeq_organism': '([A-Za-z /-]*)'", str(record))
            lineage = record[0]['GBSeq_taxonomy']
            organism = record[0]['GBSeq_organism']
            tax_list.append(lineage + "; " + organism)

print(tax_list)
ordered_taxonomy = tax_list[0].split("; ")
split_tax_list = [set(a.split("; ")) for a in tax_list]
        
shared_list = list(split_tax_list[0].intersection(*split_tax_list[1:]))
shared_index = []
for taxa in shared_list:
    shared_index.append(ordered_taxonomy.index(taxa))
print(ordered_taxonomy[max(shared_index)])
```
    Cicadidae
    

 **note about Entrez.read()**
 
ENTREZ efetch returns a massive amount of data and I can't find good documentation about what all is available since it varies depending on the database and the entrez function

I believe that because of that variability, the read function doesn't always parse perfectly.

I found out that everything in this read command (reading from an efetch output) made a list with one item. Inside that list is a dictionary with many items. Many of those internal items are also multi-item lists with dictionaries inside each item. They are supposed to be dictionaries all the way down but that's not how it comes out.

If you want to parse through an object like this you need go to the correct list index and then use the correct key. It's a huge tree-like structure. To show all of the pieces in a dictionary put .keys() at the end 

eg.

    print(record[0].keys())
    
if you want to see all the dictionaries inside a list, either loop through it or print the whole thing. Every DictElement() indicates a different dictionary that can be accessed by a list index....

To access the lineage data we need you would do:

    record[0]['GBSeq_lineage']
But the paths to some of the items can look like this: 

    record[0]['GBSeq_feature-table'][0]['GBFeature_quals'][1]['GBQualifier_name']

For fun I might make some code that loops through the objects and makes their structure readable. But for now, if you don't want to bother with any of this the best option is to print the whole thing as a string and extract what you want with regular expressions:

eg.

    lineage = re.findall("'GBSeq_taxonomy': '([A-Za-z; /-]*)'", str(record))
    
remember that re.findall() returns a list even if there's one result! If you need this single item as a string, do:

    lineage[0]





![image.png](attachment:image.png)

http://biopython.org/DIST/docs/tutorial/images/BlastRecord.png


