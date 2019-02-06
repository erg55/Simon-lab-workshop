
### Week 10 


If you have R already installed, try to install ggtree:

```
source("https://bioconductor.org/biocLite.R")
biocLite("ggtree")
```

There will probably be many problems....hopefully we can fix them! 


Ok now load some things 
```
library(ggtree)
library(phytools)
```

Let's import our tree and look at it

```
tree1 <- read.tree("example.tre")
tree1
```

First we want to reroot the tree. If we have a single outgroup we could do it this way: 
```
tree2 <- root(tree1, which(tree2$tip.label == "Philaenus_spumarius"), edgelabel = T)
```
But we have two outgroups, so we will need to reroot based on a node. To see node labels, run 

```
plot(tree2, cex=.2) 
nodelabels()
```

We need node 61. 
```
tree2 <- root(tree1, node = 61, edgelabel = T, resolve.root = T)
```

Hmmm not my preferred look. Instead we will use the reroot function in ggtree to midpoint reroot based on node 61. Here is some information about different programs for rooting https://www.biostars.org/p/332030/?fbclid=IwAR2V2lHOWgiLVCyvUdj2SFXaoxESKxU0o5f1WJvDcXvGVY6rgURr4td-kLY

```
tree3 <- reroot(tree1, node = 61)
```

Next, we'd like to try and collapse nodes less than a certain value. Here is a script to run to implement a function to do just that.

https://github.com/AlexKnyshov/main_repo/blob/master/R/collapseN.R

Load that code and we will now have use of the collapse_nodes function which takes a tree and a threshold for collapsing nodes and adds any collapsed branch length to descendent nodes. 

```
tree4 <- collapse_nodes(tree3, 65)
```
