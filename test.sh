file=$1
echo "Testing the transducer '$file' with the input 'tests/$file.txt'"
fstcompose compiled/$file.test.fst compiled/$file.source.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt --osymbols=./syms.txt
# fstcompose compiled/$file.test.fst compiled/$file.source.fst | fstprint --isymbols=./syms.txt --osymbols=./syms.txt