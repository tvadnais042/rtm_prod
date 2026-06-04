import serial
import time
import subprocess
import os


def get_data(step):
    #print(f"Collecting step {step}")
    file = open(f'data/stability/{step:04}.csv','wb')
    rper.write(b'G')
    time.sleep(0.1)   
    for _ in range(10000):
        output = rper.readline()
        file.write(output)

    file.close()

    rper.readline().decode("utf-8") #read in the main statement
    rper.readline().decode("utf-8") #read in the main statement
    rper.readline().decode("utf-8") #read in the main statement
    # ctime = rper.readline().decode("utf-8")[0:-1]
    # print(statement)
    return

def get_EEPROM():
    print("Collecting EEPROMS")
    file = open(f'EEPROM_readout.csv','wb')
    rper.write(b'E')
    time.sleep(1)
    for i in range(16):
        output = rper.readline()
        file.write(output)
    file.close()

    return

def mainloop():
    # get to the main loop
    received = "blank"
    while "alk" not in received: 
        received = rper.readline().decode("utf-8")
    get_EEPROM()
    # while instruction != "R":
    #     if instruction == "t":
    #         rper.write(b't')
    #         talk = rper.readline().decode("utf-8")
    #         print(talk)
    #     elif instruction == "G":
    #         # print("Getting to it")
    #         get_data(step)
    #         step += 1
    #     else:
    #         print("Not valid input")
    #     instruction = input(f"Main loop: R(eboot), G(etdata), t(alk): ")  

    rper.write(b'R')
    rper.close()


# PORT = subprocess.run(["ls /dev/tty* 2>/dev/null | head -n1"],shell=True, capture_output=True).stdout.decode("utf-8")[0:-1]
PORT = "/dev/ttyACM0"
BAUD = 115200

rper = serial.Serial(PORT,BAUD, timeout=1)
mainloop()




# rper.write(b'R')
# rper.close()
