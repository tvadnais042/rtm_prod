import serial
import time
import subprocess
import os
import argparse
import sys

'''
Microcontroller function scripting access.

Commands:

    R: Put board into BOOTSEL with delay and comment

    Reboot: Put board in BOOTSEL

    t | talk: Echo "OK\n"

    l | check_loss: Check PLL Input loc,  DSPLL loc, Sticky Loc

    a | scan_bus: Scan I2C between 0 and 127 for connections

    c | config: Configure PLL from loaded register file

    E | eeprom: Get EEPROM SFP vendor data
'''

def wait_on_accept(timeout=5):
    t1 = time.time()
    while (time.time() - t1) < timeout:
        received = rper.readline().decode("utf-8")
        if received.strip()=="OK":
            return
    raise Exception("NOT IN ACCEPT STATE")
    

#This is for the other version of the code isnt it??????
def get_data(step):
    #print(f"Collecting step {step}")
    file = open(f'data/stability/{step:04}.csv','wb')
    rper.write(b'G\n')
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

def get_SFP():
    print("Collecting SFPs")
    
    rper.write(b'SFP\n')
    assert "ACK" in rper.readline().decode("utf-8")
    
    with open(f'SFP_readout.csv','w') as file:
        while (True):
            output = rper.readline()
            if output.strip() == b'OK': break # recevied may depend only on whats requested in the future
            filtered = bytes(char for char in output if ((char < 0x80) & (char != 0x00))) #remove ugly bits
            file.write(filtered.decode("utf-8"))
    return

def config_pll():
    print("Configuring PLL")
    rper.write(b'c\n')
    wait_on_accept()
    return

def mainloop():
    
    received = rper.readline().decode("utf-8") 
    
    while "OK" not in received: 
        if received=="":
            rper.write(b't\n')
        elif "ACK" in received:
            pass
        else:
            print(received)
        received = rper.readline().decode("utf-8")
    
    # Accept State
    # TODO Replace with argparse
    arg1 = sys.argv[1]
    if (arg1=="R"):
        rper.write(b"R\n")
    elif (arg1=="eeprom_sfp") or (arg1=="SFP"):
        get_SFP()
    elif (arg1=="config") or (arg1=="a"):
        config_pll()
    elif (arg1=="shift") or (arg1=="s"):
        rper.write(b"shift\n")
        wait_on_accept(timeout=5)
    elif (arg1=="shiftlarge") or (arg1=="S"):
        rper.write(b"shiftlarge\n")
        wait_on_accept()
    elif (arg1=="eeprom") or (arg1=="E"):
        rper.write(b"E\n")
    else:
        print("Invalid command Bozo")

    rper.close()
    return

# PORT = subprocess.run(["ls /dev/tty* 2>/dev/null | head -n1"],shell=True, capture_output=True).stdout.decode("utf-8")[0:-1]
PORT = "/dev/ttyACM0"
BAUD = 115200

flash_script = os.path.dirname(os.path.abspath(__file__)) + "/" + "flash.sh"
subprocess.run(["sudo",flash_script], stdout=subprocess.DEVNULL) # Silence stdout

while True:
    try:
        rper = serial.Serial(PORT,BAUD, timeout=2)
        break
    except:
        pass
print(f"Connected to {PORT}")
mainloop()
