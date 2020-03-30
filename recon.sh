#!/bin/bash
for i in $(cat $1)
do
        mkdir ~/recon/$i
        cd ~/recon/$i
        crtsh $i | tee -a recon.crtsh.txt
        assetfinder --sub-only $i > recon.asset.txt
        findomain -t $i -u ~/recon/$i/recon.findomain.txt
        python3 ~/tools/github-search/github-subdomains.py -t c5070e393359bf9bfeaf870fc6ad8136070697af -d $i > recon.github.txt
        cat recon* | sort -u > all.recon.txt
        cat all.recon.txt | httprobe -c 50 | tee -a httprobe.recon.txt
        grep https httprobe.recon.txt | tee -a https443.recon.txt
        grep -v https httprobe.recon.txt | tee -a http80.recon.txt
done

