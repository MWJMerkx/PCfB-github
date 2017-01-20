#!/bin/bash

# function that will align and analyse multiple sequences using clustal-w, phyml, and nw_display

# function input in order: $1 $2 $3 
# input file = $1
# output file name = $2
# phyml bootstrap value = $3





##### function designation is currently commented out to let file be run as .sh script




# designate the function name
#treegenerator(){

	# short summary of input and contents of the input file
	echo "Input file: $1"
	echo "Output file: $2"
	echo "Number of Bootstraps: $3"
	echo "Number of sequences found for each species in the inputfile:"
	grep ">" $1 | cut -f 1,2 -d "_" | cut -f 2 -d ">" | tr '_' '.' | sort | uniq -c
	
	# uses the input file to execute the clustal-w program using the preset 	variables
	# exports the process to logfile.txt
	
	clustalw -infile=$1 -type=DNA -outfile=out_ali.phy -output=PHYLIP > logfile.txt

	# uses a standard bootstrap value for preforming the phyml analysis on 		the clustal-w output unless a bootstrap value is specified by the user, 	in which case that one is used
	# appends the output to logfile.txt
	
	Boots=100
	if [ $3 ]
	then
		Boots=$3
	fi
	phyml -i out_ali.phy -d nt -n 1 -b $Boots -m HKY85 >> logfile.txt
	
	# creates a phylogenetic tree from the phyml output
	
	nw_display -s -S -v 25 -b ’opacity:0’ -i ’font-size:8’ out_ali.phy_phyml_tree.txt > $2.svg
	
#}

