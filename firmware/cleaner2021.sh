#!/bin/bash
sleep 10 
python3 assignModelCSV2021.py mintsDefinitions_CN.yaml
sleep 10
python3 deleteTodaysData2021.py mintsDefinitions_CN.yaml  
