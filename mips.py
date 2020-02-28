import argparse
import re

def rw_file(in_file, out_file, dic):
    with open(in_file, "r") as f:
        output = open(out_file, "w")
        # assume the input file has .globl
        while True:
            line = f.readline()
            if line.strip("\t").startswith("."):
                while True:
                    if line.strip("\t").startswith(".globl"):
                        break
                    output.write(line)
                    line = f.readline()
            if line.strip("\t").startswith(("#", ".", "\n")):
                output.write(line)
                continue  

            # assume the instruction does not start with "#"
            full_line = line.split("#")  
            instruct = full_line[0]
        
            full_line = convert(instruct, full_line, dic)    
            output.write(full_line)

            if not line:
                break

    output.close()

def convert(instruct, full_line, dic):
    inst = instruct.strip("\t ")
    try:
        first_space = re.findall(r'[\s]{1,}',inst)[0]
    except:
        first_space = ""
    try:
        last_space = re.findall(r'[\s]{1,}$',instruct)[0]
    except:
        last_space = ""
    comment = ["#" + str(each) for each in full_line[1:]]
    words = instruct.replace("\t", " ").strip().split()
    for i in range(len(words)):
        match1 = re.search("[\$\w](" + "|".join(dic.keys()) +")", words[i])
        match2 = re.search("(" + "|".join(dic.keys()) + ")\w", words[i])
        match3 = re.search("(" + "|".join(dic.keys()) + ")[\)\W]*$", words[i])
        if match1 == match2 == None and match3:
            pattern = re.compile("|".join(dic.keys()))
            words[i] = pattern.sub(lambda m: dic[re.escape(m.group(0))], words[i])
    first_two_words = first_space.join(words[:2])
    final_words = [first_two_words] + words[2:]
    full_line = ["\t".join(final_words)] + comment
    full_line = last_space.join(full_line)

    if len(words) > 1 or words == ["syscall"]:
        full_line = "\t" + full_line
        if not full_line.endswith("\n"):
            full_line += "\n"
    else:
        full_line += "\n"
    return full_line

def make_dic():
    dic = {}
    names = ["zero", "at", "gp", "sp", "fp", "ra", "v0", "v1", "k0", "k1"]

    numA = 4
    numT = 10
    numS = 8

    for i in range(numA):
        key = "a" + str(i)
        dic[key] = "$" + key 
    
    for i in range(numT):
        key = "t" + str(i)
        dic[key] = "$" + key 
    
    for i in range(numS):
        key = "s" + str(i)
        dic[key] = "$" + key 

    for key in names:
        dic[key] = "$" + key 
        
    return dic


def main(args):
    register_dic = make_dic()
    rw_file(args.input, args.output, register_dic)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', 'input', type=str, help='path of the input file')
    parser.add_argument('-o', '--output', type=str, help='path of the output file')
    args = parser.parse_args()
    main(args)
