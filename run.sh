#!/bin/bash

mkdir -p compiled images

for i in sources/*.txt; do
	echo "Compiling Source: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done

for i in tests/*.txt; do
	echo "Compiling Test: $i"
    fstcompile --isymbols=syms.txt --acceptor $i | fstarcsort > compiled/$(basename $i ".txt").fst
done

echo "Creating text2num using horas, e, minutos transducers"
fstconcat compiled/horas.fst compiled/e.fst aux.source.fst
fstconcat aux.source.fst compiled/minutos.fst compiled/text2num.fst
rm aux.source.fst

echo "Creating lazy2num using horas, e, lazye, minutos transducers"
fstconcat compiled/e.fst compiled/minutos.fst auxminutos.source.fst
fstunion auxminutos.source.fst compiled/lazye.fst auxminutos.source.fst
fstconcat compiled/horas.fst auxminutos.source.fst compiled/lazy2num.fst
rm auxminutos.source.fst

echo "Creating rich2text using skiptexthoras, skipe, quartos transducers"
fstconcat compiled/skiptexthoras.fst compiled/skipe.fst aux.source.fst
fstunion compiled/quartos.fst compiled/meias.fst aux2.source.fst
fstconcat aux.source.fst aux2.source.fst compiled/rich2text.fst
rm aux.source.fst aux2.source.fst

echo "Creating rich2num using horas, e, lazye, meias, quartos, skiptextminutos, minutos transducers"
fstunion compiled/meias.fst compiled/quartos.fst auxminutos.source.fst
fstconcat compiled/skiptextminutos.fst compiled/skiptextminutostext.fst auxminutos2.source.fst
fstunion auxminutos.source.fst auxminutos2.source.fst auxminutos.source.fst
fstcompose auxminutos.source.fst compiled/minutos.fst auxminutos.source.fst
fstconcat compiled/e.fst auxminutos.source.fst auxminutos.source.fst
fstunion auxminutos.source.fst compiled/lazye.fst auxminutos.source.fst
fstconcat compiled/horas.fst auxminutos.source.fst compiled/rich2num.fst
rm auxminutos.source.fst auxminutos2.source.fst

echo "Creating num2text using fullhoras, e, fullminutos transducers"
fstconcat compiled/fullhoras.fst compiled/e.fst aux.source.fst
fstconcat aux.source.fst compiled/fullminutos.fst aux.source.fst
fstinvert aux.source.fst compiled/num2text.fst
rm aux.source.fst

for i in compiled/*.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done