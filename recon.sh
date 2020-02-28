#!/bin/bash
for i in $(cat $1)
do
        mkdir ~/recon/$i
        cd ~/recon/$i
        crtsh $i | tee -a recon.crtsh.txt
        subfinder -d $i -o ~/recon/$i/recon.subfinder.txt
        findomain -t $i -u ~/recon/$i/recon.findomain.txt
        cat recon* | sort -u > all.recon.txt
        cat all.recon.txt | httprobe -c 50 | tee -a httprobe.recon.txt
        grep https httprobe.recon.txt | tee -a https443.recon.txt
        grep -v https httprobe.recon.txt | tee -a http80.recon.txt
done
