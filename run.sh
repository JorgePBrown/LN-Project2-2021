#!/bin/bash

mkdir -p compiled images

for i in sources/*.txt; do
	echo "Compiling Source: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").source.fst
done

for i in tests/*.txt; do
	echo "Compiling Test: $i"
    fstcompile --isymbols=syms.txt --acceptor $i | fstarcsort > compiled/$(basename $i ".txt").test.fst
done


# TODO


for i in compiled/*.source.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done

#echo "Testing the transducer 'horas' with the input 'tests/numero.txt'"
#fstcompose compiled/numero.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt --osymbols=./syms.txt
