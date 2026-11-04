import re
import numpy as np
import os
from datetime import datetime
from db_dataclasses import *
from config import *
import pickle
from db_helpers import concur


def get_power(message):
    while True:
        power = float(input(message))
        if power < 0:
            print(f"We Respect Entropy Here! (Power must be >= 0) ")
            continue
        else:
            return power

def get_user_board(DB,board_type):
    assert board_type.strip().upper() in ["RTM","MMC","DDMTD","SFP","SMA","CDR"], "Not valid board type" # just to make sure I dont mistype in the steps
    while True:
        user_board = input(f"{board_type} Board ID: ").strip().upper()
        try:
            TYPE,VERSION,NUM = parse_board_ID(user_board) # check if valid Format
        except ValueError as exception: 
            print(exception)
            continue

        if TYPE != board_type:
            print(f"Board {user_board} isn't of type {board_type}")
        else: 
            break
    return user_board

def parse_board_ID(board_ID):
    assert type(board_ID) == str, "board_ID must be str"
    board_ID = board_ID.strip().upper()
    matched = re.match(r"^([A-Za-z]+)(\d{2})(\d{5})$",board_ID)
    if matched:
        TYPE, VERSION, NUM = matched.groups()
    else:
        raise ValueError("Invalid ID Format")
    return TYPE, VERSION, NUM

def board_exists(db_path: str, board_ID: str) -> bool:
    """Returns true if a board for the given ID exists"""
    con, cur = concur(db_path)
    df = cur.execute("SELECT 1 FROM Boards WHERE board_ID = ?",(board_ID,))
    return df.fetchone() is not None


def insert_board(db_path, board_ID, power_draw):
    TYPE, VERSION, NUM = parse_board_ID(board_ID)
    record = Board(board_ID,TYPE,VERSION,NUM,power_draw)
    insert_single(db_path,record)

def read_eyes(DB:str, board:str):
    with open(f"live_tests/SFP_readout.csv","r") as file:
        SFP_plugs = np.genfromtxt(file, delimiter=',',dtype=str)

    for i in range(4):
        assert i==int(SFP_plugs[i][3])
        SFP_plug = str(SFP_plugs[i][5]).strip() + "," + str(SFP_plugs[i][7]).strip()
        read_eye(DB,board,i,SFP_plug,f"live_tests/Scan_{i}.csv")

def read_eye(db_path, board_ID, link, SFP_serial, eye_csv_path, eye_img_path=None):
    with open(eye_csv_path, "rb") as file:
        eye_csv = file.read()
    if eye_img_path == None:
        eye_img = None
    else:
        with open(eye_img_path, "rb") as file:
            eye_img = file.read()

    csv_dict = parse_eye_csv(eye_csv_path) #FIXME What am I doing here?
    fixdate = lambda s: datetime.strptime(s, "%Y-%b-%d %H:%M:%S").strftime("%Y-%m-%d %H:%M:%S")
    time_start = fixdate(csv_dict["Date and Time Started"])
    time_end = fixdate(csv_dict["Date and Time Ended"])

    record = Eye_diagram(board_ID,link,time_start,time_end,pickle.dumps(csv_dict),eye_img,SFP_serial)
    insert_single(db_path,record)
    return

def parse_eye_csv(csv_path:str) -> dict:
    with open(csv_path, 'r') as file:
        csv_data = np.genfromtxt(file, delimiter=',', max_rows=19, encoding='UTF-8', dtype=None)
    csv_parsed = dict(csv_data.tolist())
    csv_parsed.pop("Scan Name")
    csv_parsed.pop("Misc Info")
    csv_parsed.pop("SW Version")
    csv_parsed.pop("Reset RX After Applying Settings")
    # ATP clean the types of everything you want
    # print(csv_parsed)
    return csv_parsed

def read_BER(DB:str, board:str):
    for i in range(4):
        with open(f"live_tests/BER_results_1_{i}.csv", 'r') as file:
            csv_data = np.genfromtxt(file, delimiter=',', dtype=str)
        csv_data = dict(csv_data.tolist())
        record = BER_test(
            board_ID = board,
            link = int(csv_data["link"]),
            mezzanine = int(csv_data["mezzanine"]),
            time_start = str(csv_data["time_start"]),
            rate = float(csv_data["LINE_RATE"]),
            bits_transmitted = int(csv_data["RX_RECEIVED_BIT_COUNT"]),
            errors = int(csv_data["LOGIC.ERRBIT_COUNT"],base=16),
            error_rate = float(csv_data["RX_BER"]),
            PATTERN = csv_data["PATTERN"],
            TXPRE = float(csv_data["TXPRE"].split()[0]),
            TXPOST = float(csv_data["TXPOST"].split()[0]),
            TXDIFFSWING = int(csv_data["TXDIFFSWING"].split()[0]),
            RXTERM = int(csv_data["RXTERM"].split()[0]),
            GPIO_Q2 = None)
        insert_single(DB,record)

def read_GPIO(DB:str, board:str):
    with open(f"live_tests/vio_out.csv", 'r') as file:
        csv_data = np.genfromtxt(file,delimiter=',', dtype=str)
        csv_data = dict(csv_data.tolist())
        bits_transmitted = int(csv_data["count_total"],base=16)
        time_start = csv_data["time_start"]

        for key in csv_data.keys():
            if "MEZZ" in key:
                err = int(csv_data[key],base=16)
                mezzanine, Qnum, link = re.search(r"MEZZ(\d{1})(?:_(Q)\d{1})?\[(\d{1})\]",key).groups()
                record = BER_test(
                    board_ID = board,
                    link = link, # potential issue if CDR mezz labels are not concurrent with test performed
                    mezzanine = mezzanine,
                    time_start = time_start,
                    rate = GPIO_RATE,
                    bits_transmitted = bits_transmitted,
                    errors = err,
                    error_rate = (1+err)/bits_transmitted,
                    PATTERN = "PRBS 31_bit",
                    TXPRE = None, TXPOST = None, TXDIFFSWING = None, RXTERM = None,
                    GPIO_Q2 = True if Qnum != None else False)
                insert_single(DB,record)

def read_ILA(DB:str, board:str, net_whitelist: list|None):
    with open(f"live_tests/iladata.csv") as file:
        csv_data = np.genfromtxt(file,delimiter=',',names=True,dtype=int)[1:] #[1:] gets rid of Type-specifier line
        if net_whitelist is not None:
            net_whitelist = ["prbs_data"]+net_whitelist
            csv_data = csv_data[net_whitelist]
    time_start = str(datetime.now())
    record = Ila(board,time_start,GPIO_RATE,pickle.dumps(csv_data))    
    insert_single(DB,record)
    
def read_eeproms(DB:str, board:str, slot:int):
    name,_,_ = parse_board_ID(board)

    with open(f"live_tests/eeprom_{name}{slot}.csv") as file:
        csv_data = np.genfromtxt(file,delimiter=',',dtype=bytes)
        record = EEPROM(board,pickle.dumps(csv_data),slot)
        insert_single(DB,record)

def read_DDMTD(DB:str, board:str, data_path:str, shift_hold_time:int):
    with open(f"{data_path}/ddmtd1.txt") as file:
        data_1 = np.genfromtxt(file,dtype=bytes)
    with open(f"{data_path}/ddmtd2.txt") as file:
        data_2 = np.genfromtxt(file,dtype=bytes)
    with open(f"{data_path}/ddmtd3.txt") as file:
        data_3 = np.genfromtxt(file,dtype=bytes)
    time_start = datetime.fromtimestamp(os.path.getctime(f"{data_path}/ddmtd1.txt"))
    step_size_multiplier = 0xf #This is from rtmMC/rtmMC.c but I should parametrize it maybe. 
    record = ddmtd(board,time_start,pickle.dumps(data_1),pickle.dumps(data_2),pickle.dumps(data_3),shift_hold_time,step_size_multiplier)
    insert_single(DB,record)