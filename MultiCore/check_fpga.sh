#!/bin/bash

#echo "start clean"
#make clean
#echo "start source checking"
#testasm -c
#echo "start mapped checking"
#testasm -s -c
echo "start fpga checking"
for f in asmFiles/*.asm
do
	echo "processing $f"
	asm $f
	sim -m
	synthesize -d -m system_fpga
	diff -y memfpga.hex memsim.hex > $f.out
done

asm asmFiles/example.asm
sim -m
synthesize -d -m system_fpga
