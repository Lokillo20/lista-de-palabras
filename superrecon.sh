#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Obtener los subdominios con todas las herramientas y en una sola lista"
        echo "Usage: ./Recon.sh <domain>"
        echo "Example: ./Recon.sh yahoo.com"
        exit 1
fi

mkdir Recon-$1

echo "Obteniendo subdominios con Findomain..."

findomain -t $1 -u Recon-$1/findomain-$1.txt

echo "Obteniendo subdominios con CRT.SH..."

curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe | tee -a Recon-$1/crtsh-$1.txt
