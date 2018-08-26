import os
import re

reFrom = "l16"
reTo = "mts"
print("Replacing '"+ reFrom +"' with '"+ reTo +"':")

def iterateDir(path):
    for filename in os.listdir(path):
        if filename.endswith(".paa") & (re.search(reFrom, filename) is not None):
            print(path+"\\"+filename)
            newName = re.sub(reFrom, reTo, filename)
            os.rename(path+"\\"+filename, path+"\\"+newName)
        elif os.path.isdir(path+"\\"+filename):
            iterateDir(path+"\\"+filename)

iterateDir(os.getcwd())

print("Replacing finished.")
