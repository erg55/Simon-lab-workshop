
### Week 10 

#### GGtree


If you have R already installed, try to install ggtree:

```
source("https://bioconductor.org/biocLite.R")
biocLite("ggtree")
```


Ok now lets install/load some things 
```
library(ggtree)
install.packages(c("ape","phytools","ggplot2"))
library(ape)
library(phytools)
library(ggplot2)


```
There will probably be many problems....hopefully we can fix them! 


Let's import our tree which is the a standard bipartitions file from RAxML and look at it. Make sure and update your working directory to what ever folder has the tree in it. You can download the files from this github page. 

```
tree1 <- read.tree("example.tre")
tree1
plot(tree1)
```


First we want to reroot the tree. If we have a single outgroup, we could do it this way: 
```
tree2 <- root(tree1, which(tree1$tip.label == "Philaenus_spumarius"), edgelabel = T)
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
plot(tree2)
```

Hmmm not my preferred look. Instead we will use the reroot function in ggtree to midpoint reroot the outgroup branch based on node 62. Here is some information about how different programs root https://www.biostars.org/p/332030/?fbclid=IwAR2V2lHOWgiLVCyvUdj2SFXaoxESKxU0o5f1WJvDcXvGVY6rgURr4td-kLY

```
tree3 <- ggtree::reroot(tree1, 62)
plot(tree3)
```

Ok now let's create a file with our tree and the ggtree function. We will make it a pdf so everyone's tree will hopefully look the same regardless of screens etc. It will be made in your output directory. We can also import this into Illustrator or Inkscape later. The extension .svg is also an option. 

```
pdf("output.pdf", width=8.5, height=11)
ggtree(tree3)
dev.off()
```


![sadtree](https://github.com/erg55/Simon-lab-workshop/blob/master/R/output1.jpg)

Oops that's not super useful. We need to add in some additional stuff for tip labels and bootstrap supports. 

```
pdf("output.pdf", width=8.5, height=11)
ggtree(tree3) +
geom_tiplab(size=2) + 
geom_text2(aes(subset = !isTip & as.numeric(label) > 50, label=label, x =branch), vjust =-0.1, size = 2) 
dev.off()
```

Looking better but our trees is going off of the file so we will need one more thing:

```
pdf("output.pdf", width=8.5, height=11)
ggtree(tree3) +
geom_tiplab(size=2) + 
geom_text2(aes(subset = !isTip & as.numeric(label) > 50, label=label, x =branch), vjust =-0.1, size = 2) +
xlim(0,5.5)
dev.off()
```


Next, we'd like to try and collapse nodes less than a certain value. Here is a some text to run to implement a function to do just that.

https://github.com/AlexKnyshov/main_repo/blob/master/R/collapseN.R

Load that code and we will now have use of the collapse_nodes function which takes a tree and a threshold for collapsing nodes and adds any collapsed branch length to descendent nodes. 

```
tree4 <- collapse_nodes(tree3, 65)
```

```
pdf("output.pdf", width=8.5, height=11)
ggtree(tree4) +
geom_tiplab(size=2) + 
geom_text2(aes(subset = !isTip & as.numeric(label) > 50, label=label, x =branch), vjust =-0.1, size = 2) +
xlim(0,5.5)
dev.off()
```

You can also save things with ggsave as long as you save the ggtree object into its own file. 

```
t4 <- geom_tiplab(size=2) + 
geom_text2(aes(subset = !isTip & as.numeric(label) > 50, label=label, x =branch), vjust =-0.1, size = 2) +
xlim(0,5.5)
ggsave("output.svg", t4, scale =0.8)
```


We can also try and do some fancy functions within ggtree like changing the tree shape or changing the tip colors. 


```
ggtree(tree4, layout="daylight")
tree5 <- ggtree(tree4, layout="daylight")
tree5 + geom_tiplab(size=2, color="magenta")
```

There are many other functions you can try available here https://bioconductor.org/packages/release/bioc/vignettes/ggtree/inst/doc/treeVisualization.html#zoom-on-a-portion-of-tree


Ok now let's do some metadata annotation.

```
tab <- read.csv("Cicadaclass.csv", stringsAsFactors=F)
```
We need to parse out the table into the different values.
```
cls <- list(Cicadettinae=tab$name[tab$subfamily=="Cicadettinae"], Cicadinae=tab$name[tab$subfamily=="Cicadinae"], Tettigarctidae=tab$name[tab$subfamily=="Tettigarctidae"], Tettigadinae=tab$name[tab$subfamily=="Tettigadinae"], Derotettiginae=tab$name[tab$subfamily=="Derotettiginae"], Tettigomyiinae=tab$name[tab$subfamily=="Tettigomyiinae"])

```

```
tree6 <- groupOTU(tree4,cls)
pdf("output.pdf", width=8.5, height=11)
ggtree(tree6, aes(color=group)) +
geom_tiplab(size=2) + 
geom_text2(aes(subset = !isTip & as.numeric(label) > 50, label=label, x =branch), vjust =-0.1, size = 2) +
xlim(0,5.5)
dev.off()
```
Let's add a legend: 


```
tree6 <- groupOTU(tree4,cls)
pdf("output.pdf", width=8.5, height=11)
ggtree(tree6, aes(color=group)) +
geom_tiplab(size=2) + 
geom_text2(aes(subset = !isTip & as.numeric(label) > 50, label=label, x =branch), vjust =-0.1, size = 2) +
xlim(0,5.5) + 
theme(legend.position=c(0.2, 0.6), legend.title = element_blank())
dev.off()
```

And finally lets say we want to get rid of the unlabelled stuff in the legend and change the colors from the default
```
tree6 <- groupOTU(tree4,cls)
pdf("output.pdf", width=8.5, height=11)
ggtree(tree6, aes(color=group)) +
  geom_tiplab(size=2) + 
  geom_text2(aes(subset = !isTip & as.numeric(label) > 50, label=label, x =branch), vjust =-0.1, size = 2) +
  xlim(0,5.5) +
  theme(legend.position=c(0.2, 0.6), legend.title = element_blank()) +
  scale_color_manual(values = c("0"="black",Tettigarctidae="black",Cicadettinae="blue",Cicadinae="darkblue",Tettigadinae="darkred",Derotettiginae="red",Tettigomyiinae="purple"), 
                     breaks= c("Tettigarctidae","Cicadettinae","Cicadinae","Tettigadinae", "Derotettiginae","Tettigomyiinae"))
dev.off()
```
