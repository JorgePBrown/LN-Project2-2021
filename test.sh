tested=$1
tester=$2
echo "Testing the transducer '$tested' with the input '$tester'"
fstcompose compiled/$tester.fst compiled/$tested.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt --osymbols=./syms.txt
# fstcompose compiled/$file.test.fst compiled/$file.source.fst | fstprint --isymbols=./syms.txt --osymbols=./syms.txt