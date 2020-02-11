#!/bin/bash

for i in $(cat $1); do
        echo "$i" >> $1.js.txt && python3 linkfinder.py -i $i -o cli >> $1.js.txt
done
