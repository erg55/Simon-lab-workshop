counter=0;for f in `cat lookup.txt`;do replace[counter]=$f;counter=$counter+1;done;counter2=0; for ((a=0; a <= $counter-1; a=a+2)); do `sed -i "s/${replace[$a]}/${replace[$a+1]}/g" *.fasta` ;done;
