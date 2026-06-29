from tools.base import *
from tools.ddmtd import *
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from time import sleep 
from copy import deepcopy
import subprocess

import matplotlib
matplotlib.style.available
# matplotlib.style.use(['seaborn-darkgrid'])
# plt.rcParams['figure.figsize'] = [4, 3]
plt.rcParams['figure.dpi'] = 100
# pd.set_option('max_columns', None)
# pd.set_option('max_rows', 100)

def data2df(data_folder="./data_files"):
    # Make Column Names
    NUM_WORDS = 24
    column_names = []
    for i in range(1,NUM_WORDS+1):
        column_names.append(f"edge{i}")
        column_names.append(f"ddmtd{i}")

    dv1= pd.read_csv(f"{data_folder}/ddmtd1.txt",sep=",",header=0 ,skiprows=0,names=column_names[0:16])
    dv2= pd.read_csv(f"{data_folder}/ddmtd2.txt",sep=",",header=0 ,skiprows=0,names=column_names[16:32])
    dv3= pd.read_csv(f"{data_folder}/ddmtd3.txt",sep=",",header=0 ,skiprows=0,names=column_names[32:48])
    dv = pd.concat((dv1,dv2,dv3),axis=1)  
    df = deepcopy(dv)
    return df 

def get_ddmtd_obj(df,freq=160*10**6, data_stream = (1,3)):
    data = ddmtd(deepcopy(df),q=1,channel=data_stream)
    data.N=100_000
    data.INPUT_FREQ = freq
    data.Recalc()
    return data

def phase(i, qn):
    # qn indexed 1-24. 1,2,3,4,5 -> Q0,Q1,Q2,Q3,Q4. Q0 ref.
    return get_ddmtd_obj(data2df(data_folder=f"./data_files/{i}"),data_stream = (1,qn)).drawTIE(save_name=f"q{qn-1}_{i}",fit=True,draw=True)


#Compiles get_bram_data.c and loadapp
# subprocess.run(["./load_data_acq.sh"]) #run once for setup
# subprocess.run(["python","../rtmMC/host.py","config"])


#Collect some data
subprocess.run(["./get_data_kria.sh","0"])
print(phase(0,2))
subprocess.run(["python","../rtmMC/host.py","shiftlarge"])
subprocess.run(["./get_data_kria.sh","1"])
print(phase(1,2))
subprocess.run(["python","../rtmMC/host.py","shiftlarge"])
subprocess.run(["./get_data_kria.sh","2"])
print(phase(2,2))
subprocess.run(["python","../rtmMC/host.py","shiftlarge"])
subprocess.run(["./get_data_kria.sh","3"])
print(phase(3,2))


# plt.scatter(range(ddmtd1.TIE_fall.size),ddmtd1.TIE_fall)
# np.savetxt("shiftQ4", q4, delimiter=",")

