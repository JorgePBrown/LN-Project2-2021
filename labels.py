import sys

_col = int(sys.argv[1])
_in = sys.argv[2]
_out = sys.argv[3]

with open(_in) as i:
    with open(_out, "w") as o:
        for line in i.readlines():
            split = line.split("\t")
            if len(split) > 1:
                if _col != 3:
                    o.write(f"{split[_col]}\n")
                else:
                    o.write(f"{split[_col]}")
            
