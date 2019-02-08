
### Week 10 


If you have R already installed, try to install ggtree:

```
source("https://bioconductor.org/biocLite.R")
biocLite("ggtree")
```

There will probably be many problems....hopefully we can fix them! 


Ok now load some things 
```
library(ape)
library(ggplot2)
library(ggtree)
library(phytools)
```
There will probably be many problems....hopefully we can fix them! 


Let's import our tree and look at it. MAke sure and update your working directory to what ever folder has the tree in it. You can download the files from this page. 

```
tree1 <- read.tree("example.tre")
tree1
plot(tree1)
```
Be warned you may have to run dev_off after using plot to get it to update to new plots. 


First we want to reroot the tree. If we have a single outgroup we could do it this way: 
```
tree2 <- root(tree1, which(tree2$tip.label == "Philaenus_spumarius"), edgelabel = T)
plot(tree2)
```
But we have two outgroups, so we will need to reroot based on a node. To see node labels, run the following using the ces to make the node labels smaller:

```
plot(tree1, cex=.2) 
nodelabels()
```




We need node 62. Run dev.off() to close the plot before doing anything else. 
```
dev.off() 
```

Now reroot like this:
```
tree2 <- root(tree1, node = 62, edgelabel = T, resolve.root = T)
```

Hmmm not my preferred look. Instead we will use the reroot function in ggtree to midpoint reroot the outgroup branch based on node 62. Here is some information about how different programs root https://www.biostars.org/p/332030/?fbclid=IwAR2V2lHOWgiLVCyvUdj2SFXaoxESKxU0o5f1WJvDcXvGVY6rgURr4td-kLY

```
tree3 <- ggtree::reroot(tree1, 62)
```



Next, we'd like to try and collapse nodes less than a certain value. Here is a script to run to implement a function to do just that.

https://github.com/AlexKnyshov/main_repo/blob/master/R/collapseN.R

Load that code and we will now have use of the collapse_nodes function which takes a tree and a threshold for collapsing nodes and adds any collapsed branch length to descendent nodes. 

```
tree4 <- collapse_nodes(tree3, 65)
```

We can try and do some fancy functions within ggtree like changing the tree shape. 


```
ggtree(tree4, layout="daylight")
tree5 <- ggtree(tree4, layout="daylight")
```

```
tree5 + geom_tiplab(size=2, color="magenta")
```


