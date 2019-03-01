
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

------------------------------------------------------------------------------------------

   **Note on Biopython in the cluster and version control**
The cluster has a few random versions of python to choose from, and the packages within them are maintained by someone else. As a result, only one of them has BioPython installed: python/2.7.8

You can develop scripts for this version of python, but biopython is very out of date and you can't use the 'qblast()' function, nor 'Entrez.read()', and probably some others that I haven't tried. The best way around this is to install your own updated version of python in a virtual environment, which lets you add your own packages!

**creating virtualenv for a python version**
The virtualenv copies the version of python that is currently loaded. 'py-3.6.3' is just the name of the folder, which I made match the python version.
This works with any version of python on the cluster

_don't execute this, just run the source command in the next code block_
After logging into the cluster:

    module unload python
    module load python/3.6.3
    virtualenv py-3.6.3
    module unload python
    source /py-3.6.3/bin/activate
    pip install biopython
    
To exit the virtual environment type `deactivate`
    
    
Our lab has started a group virtual environment so we can all have the same packages. You can activate it with

    source /UCHC/LABS/Simon/venv/py-2.7.14/bin/activate

## Biopython
Biopython is a massive python module and I won't cover most of it. All of its capabilities are listed here: http://biopython.org/DIST/docs/tutorial/Tutorial.html

##### Every module 
```python
from Bio.Align.Applications import MafftCommandline
from Bio.Blast import NCBIWWW
from Bio.Blast import NCBIXML
from Bio import SeqIO
from Bio import Entrez
from Bio import AlignIO
from StringIO import StringIO
import random
import sys
import os
import re
```

### SeqIO
Read and manage sequence data
Supports many file formats
Two methods for reading fasta files are given:
```python
#most memory efficient method
#must do all your analysis within this for loop (sequences are lost after)
for seq in SeqIO.parse("/UCHC/LABS/Simon/Python_Test/mystery.fasta", "fasta"):
    print(seq.id)
    print(seq.seq[:50] + "...")

#stores all sequences in a list which can be referred back to
sequence_record = list(SeqIO.parse("/UCHC/LABS/Simon/Python_Test/mystery.fasta", "fasta"))
for seq in sequence_record:
  print(seq.id)
  print(seq.seq[:50] + "...")
```

### Blast
Online blast, and parsing the blast object
Full structure of the blast object: http://biopython.org/DIST/docs/tutorial/images/BlastRecord.png
```python
#Simple case
with open("/UCHC/LABS/Simon/Python_Test/singleseq.fasta", "r") as f:
  single_sequence = f.read()
handle = NCBIWWW.qblast("blastn", "nt", single_sequence)
blast_record = NCBIXML.read(handle)

#parsing the blast object
for alignment in blast_record.alignments[:10]:
    for hsp in alignment.hsps:
        if hsp.expect < 1e-10:
            print(alignment.title)
            print("length:" + str(alignment.length))
            print("e-value:" + str(hsp.expect))
            print("identities:" + str(hsp.identities))
            print(hsp.query[:50] + "...")
            print(hsp.match[:50] + "...")
            print(hsp.sbjct[:50] + "...")
            print("")

# other blast programs work too
def translate_max_ORF(sequence):
    table = 11
    min_pro_len = 100
    prolist = []
    for strand, nuc in [(+1, sequence), (-1, sequence.reverse_complement())]:
        for frame in range(3):
            length = 3 * ((len(sequence)-frame) // 3)
            for pro in nuc[frame:frame+length].translate(table).split("*"):
                prolist.append(pro)
    print("ORF found")
    return max(prolist, key=len)

s = SeqIO.read("/UCHC/LABS/Simon/Python_Test/singleseq.fasta", "fasta")
translated = translate_max_ORF(s.seq)
print(translated)
handle = NCBIWWW.qblast("blastp", "nr", single_sequence)
blast_record = NCBIXML.read(handle)
```

### Entrez
Entrez 
```python
#Shows all available databases
Entrez.email = "jason.vailionis@uconn.edu"
handle = Entrez.einfo()
record = Entrez.read(handle)
print(record.keys())
print(record['DbList'])

#search any database with a keyword, and extract ids of results
handle = Entrez.esearch("nucleotide", "aurelia aurita mitochondria")
record = Entrez.read(handle)
print(record.keys())
print(record['IdList'])
print(record['Count'])
nucleotide_ids = record['IdList']

#search the same database with that id, and extract any information
handle = Entrez.efetch("nucleotide", id=nucleotide_ids, retmode = "xml")
record = Entrez.read(handle)
print(record[0].keys())
print(record[0]['GBSeq_source'])
print(record[0]['GBSeq_sequence'])
print(record[0]['GBSeq_primary-accession'])
```

### Applied case
blasting every sequence in a file, printing output summary
assigning taxonomy based on top ten hits, writing the taxonomy into the sequence header
**This takes really long so if you want to execute it, run ##mini## and not ##main##**
**If you're running it from the command line, copy each def command separately**
```python
from Bio.Blast import NCBIWWW
from Bio.Blast import NCBIXML
from Bio import SeqIO
from Bio import Entrez
import random
import re

def assign_taxonomy(blast_object, e_cutoff = 1e10):
    Entrez.email = "jason.vailionis@uconn.edu"
    tax_list = []
    
    for alignment in blast_object.alignments[:10]:
        for hsp in alignment.hsps:
            if hsp.expect < e_cutoff:
                gi_number = re.findall("(gi\|[\d]*)\|", alignment.title)[0]
                handle = Entrez.efetch(db="Nucleotide", id=gi_number, retmode="xml")
                record = Entrez.read(handle)
                handle.close()
                #lineage = re.findall("'GBSeq_taxonomy': '([A-Za-z; /-]*)'", str(record))
                #organism = re.findall("'GBSeq_organism': '([A-Za-z /-]*)'", str(record))
                lineage = record[0]['GBSeq_taxonomy']
                organism = record[0]['GBSeq_organism']
                tax_list.append(lineage + "; " + organism)
    
    ordered_taxonomy = tax_list[0].split("; ")
    split_tax_list = [set(a.split("; ")) for a in tax_list]
            
    shared_list = list(split_tax_list[0].intersection(*split_tax_list[1:]))
    if len(shared_list) == 0:
        #This means the matches are from different kingdoms
        return "N/A"
    else:
        shared_index = []
        for taxa in shared_list:
            shared_index.append(ordered_taxonomy.index(taxa))
        return ordered_taxonomy[max(shared_index)]
    
def print_blast_summary(blast_object):
    for alignment in blast_object.alignments[:10]:
        for hsp in alignment.hsps:
            if hsp.expect < 1e-10:
                print(alignment.title)
                print("length:" + str(alignment.length))
                print("e-value:" + str(hsp.expect))
                print("identities:" + str(hsp.identities))
                print(hsp.query[:50] + "...")
                print(hsp.match[:50] + "...")
                print(hsp.sbjct[:50] + "...")
                print("")

##mini##
sequence_record = list(SeqIO.parse("/UCHC/LABS/Simon/Python_Test/mystery.fasta", "fasta"))
print(len(sequence_record))
random_seq = sequence_record[random.randint(0,9)]
print(random_seq.id)
handle = NCBIWWW.qblast("blastn", "nt", random_seq.seq)
blast_record = NCBIXML.read(handle)
print_blast_summary(blast_record)
print(assign_taxonomy(blast_record))


##main##
with open("output.fasta", "w") as f:
    for sequence in SeqIO.parse("mystery.fasta", "fasta"):
        handle = NCBIWWW.qblast("blastn", "nt", sequence.seq)
        blast_record = NCBIXML.read(handle)
        handle.close()
        print(sequence.id + "BLAST SUMMARY")
        print_blast_summary(blast_record)
        consensus_taxonomy = assign_taxonomy(blast_record, 1e-20)
        print("Best taxonomic identification: " + consensus_taxonomy)
        f.write(">" + sequence.id + "_" + consensus_taxonomy)
        f.write(sequence.seq)    
```



###Applied case
searching nt for sequences that match a keyword, writing them to a fasta file, and aligning them to a file called alignment.fasta

```python
from Bio import Entrez
from Bio.Align.Applications import MafftCommandline
from Bio import AlignIO
import os
import sys
from StringIO import StringIO
#in python3 this is from io import StringIO
#don't use sys in python3; you can refer to stdout without it

os.system("module load mafft")
Entrez.email = "jason.vailionis@uconn.edu"
handle = Entrez.esearch(db="Nucleotide", term="cicadinae COI")
record = Entrez.read(handle)
result_ids = record['IdList']

handle2 = Entrez.efetch(db="Nucleotide", id=result_ids, retmode="xml")
record2 = Entrez.read(handle2)
with open("new_fasta.fasta", "w") as f:
    for i in enumerate(record2):
        new_fasta_seq = (">" + i[1]['GBSeq_organism'] +\
                         i[1]['GBSeq_feature-table'][2]['GBFeature_quals'][3]['GBQualifier_value'] +\
                         "_" + str(i[0]) + "\n").replace(" ", "_") + i[1]['GBSeq_sequence'] + "\n"
        print(new_fasta_seq)
        f.write(new_fasta_seq)

mafft_cline = MafftCommandline(input="new_fasta.fasta")
sys.stdout, sys.stderr = mafft_cline()
with open ("alignment.fasta", "w") as f:
    f.write(sys.stdout)

#This doesn't work yet on python2, but I'll fix it some day
#you can also read in the alignment object from stdout
alignment = AlignIO.read(StringIO(sys.stdout), "fasta")
for a in alignment:
    print(a.seq)
```
