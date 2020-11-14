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

echo "Creating text2num using horas, e, minutos transducers"
fstconcat compiled/horas.source.fst compiled/e.source.fst aux.source.fst
fstconcat aux.source.fst compiled/minutos.source.fst compiled/text2num.source.fst
rm aux.source.fst

echo "Creating lazy2num using horas, e, lazye, minutos transducers"
fstconcat compiled/e.source.fst compiled/minutos.source.fst auxminutos.source.fst
fstunion auxminutos.source.fst compiled/lazye.source.fst auxminutos.source.fst
fstconcat compiled/horas.source.fst auxminutos.source.fst compiled/lazy2num.source.fst
rm auxminutos.source.fst

echo "Creating rich2text using skiptexthoras, skipe, quartos transducers"
fstconcat compiled/skiptexthoras.source.fst compiled/skipe.source.fst aux.source.fst
fstconcat aux.source.fst compiled/quartos.source.fst compiled/rich2text.source.fst
rm aux.source.fst

for i in compiled/*.source.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done