#!/usr/bin/python

import sys
import yaml
import os

print()
print("MINTS")
print()

yamlFile =  str(sys.argv[1])
print("YAML File: " + yamlFile)
print()

with open(yamlFile) as file:
    # The FullLoader parameter handles the conversion from YAML
    # scalar values to Python the dictionary format
    mintsDefinitions = yaml.load(file, Loader=yaml.FullLoader)

"rsync -avzrtu -e ssh --include='*.mat' --include='*/' --exclude='*' lhw150030@europa.circ.utdallas.edu:/home/lhw150030/mintsData/modelsMats/ /mfs/io/groups/lary/mintsData/modelsMats/"


dataFolder = mintsDefinitions['dataFolder']+ "/modelsMats/centralNodes/"
csvNow     = "WS_CN_Pre.csv"
csvWS      = "WS_CN.csv"

syncStr  = "rsync -avzrtu -e ssh lhw150030@europa.circ.utdallas.edu:/scratch/lhw150030/mintsData/modelsMats/centralNodes/ "+ dataFolder 
print(syncStr)
os.system(syncStr)

print("Assigning Model File")
sysStr = "cp " + dataFolder +  csvNow +" " + dataFolder +  csvWS
print(sysStr)
os.system(sysStr)





