import sqlite3
import re
import numpy as np
import subprocess
from datetime import datetime

from schema import create_schema, nuke, mininuke
'''
Considerations:

PlugManufacturer TEXT
if type = SMA
    plugtype=NULL
if type = SFP
    plugtype={manufacturer}

board has board info and a number of associated tests and EEPROM
EEPROM is on Mezzanine itself. We can store a full readout in the database
There can be any number of tests. 

'''

def concur(db_path, foreign_keys=True):
    con = sqlite3.connect(db_path)
    if foreign_keys:
        con.execute("PRAGMA foreign_keys = ON")
    else:
        con.execute("PRAGMA foreign_keys = OFF")
    cur = con.cursor()
    return con, cur

def parse_board_ID(board_ID):
    assert type(board_ID) == str, "board_ID must be str"
    matched = re.match(r"([A-Za-z]+)(\d{2})(\d{5})",board_ID)
    if matched:
        TYPE, VERSION, NUM = matched.groups()
    else:
        raise ValueError(f"Invalid BoardID format.")
    return TYPE, VERSION, NUM

def insert_board(db_path, board_ID):
    con, cur = concur(db_path)
    TYPE, VERSION, NUM = parse_board_ID(board_ID)
    cur.execute('''
        INSERT INTO Boards(board_ID, type, version, num, power_draw)
        VALUES(?,?,?,?,?)''',(board_ID,TYPE,VERSION,NUM,0.5))
    con.commit()
    return

def insert_BER(db_path,board_ID,link,mezzanine,time_start,rate,bits_transmitted,errors,error_rate,
               PATTERN,TXPRE,TXPOST,TXDIFFSWING,RXTERM):
    con, cur = concur(db_path)
    
    # with open("BER_results_0","r") as file:

    cur.execute('''
        INSERT INTO BER_tests(
        board_ID,link,mezzanine,time_start,rate,bits_transmitted,errors,error_rate,PATTERN,TXPRE,TXPOST,TXDIFFSWING,RXTERM)
        VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)''',
        (board_ID,link,mezzanine,time_start,rate,bits_transmitted,errors,error_rate,PATTERN,TXPRE,TXPOST,TXDIFFSWING,RXTERM)
    )
    con.commit()
    return

def insert_eye(db_path, board_ID, link, SFP_serial, eye_csv, eye_img=None):
    con, cur = concur(db_path)
    with open(eye_csv, "rb") as file:
        eye_csv_binary = file.read()
    if eye_img == None:
        eye_img_binary = None
    else:
        with open(eye_img, "rb") as file:
            eye_img_binary = file.read()
    
    csv_dict = parse_eye_csv(eye_csv)
    fixdate = lambda s: datetime.strptime(s, "%Y-%b-%d %H:%M:%S").strftime("%Y-%m-%d %H:%M:%S")
    time_start = fixdate(csv_dict["Date and Time Started"])
    time_end = fixdate(csv_dict["Date and Time Ended"])
    
    cur.execute('''
        INSERT INTO eye_diagrams(
        board_ID,link,time_start,time_end,SFP_serial,eye_csv,eye_img)
        VALUES(?,?,?,?,?,?,?)''',
        (board_ID,link,time_start,time_end,SFP_serial,eye_csv_binary,eye_img_binary)
    )
    con.commit()
    return

def insert_eeprom(db_path, board_ID, mezzanine, testnull):
    con,cur = concur(db_path)
    cur.execute('''
        INSERT INTO eeproms(
        board_ID,mezzanine,testnull)
        VALUES(?,?,?)''',
        (board_ID,mezzanine,testnull)
    )
    con.commit()
    return

def insert_ddmtd(db_path, board_ID):
    #something to be made here with new table

    return

def parse_eye_csv(csv_path): #Deprecated?
    # extracts key value pairs from eye_csv
    # NOTE do I want to include the entries as columns? Is this feature creap?
    with open(csv_path, 'r') as file:
        csv_data = np.genfromtxt(file, delimiter=',', max_rows=19, dtype=None)
    csv_parsed = dict(csv_data.tolist())
    csv_parsed.pop("Scan Name")
    csv_parsed.pop("Misc Info")

    # print(csv_parsed)
    return csv_parsed

def read_board(db_path,board_ID):
    con,cur = concur(db_path)
    df = cur.execute(f"SELECT * FROM Boards WHERE board_ID = '{board_ID}'") 
    print(*df.fetchall(),sep='\n')
    df = cur.execute(f"SELECT board_ID, link, SFP_serial, time_start, time_end FROM eye_diagrams WHERE board_ID = '{board_ID}'")
    print("Eyes: ID, Link, SFP, Start, End: ")
    print(*df.fetchall(), sep='\n')
    df = cur.execute(f"SELECT * FROM BER_tests WHERE board_ID = '{board_ID}'")
    print("BER: ID, Link, Mezzanine, tstart, rate, transmitted, errs, BER, Pattern, TXpre, TXpost, RXTERM, TXDiffswing")
    print(*df.fetchall(), sep='\n')

    return

    
def populate(db_path, board_ID):
    try:
        insert_board(db_path,board_ID)
    except:
        pass

    # subprocess.run(["./get_SFP.sh"]) # Collect from RTM
    with open(f"live_tests/EEPROM_readout.csv","r") as file:
        SFP_plugs = np.genfromtxt(file, delimiter=',',dtype=str)

    # subprocess.run(["./get_ber.sh"]) # Collect from lab
    for i in range(4):
        with open(f"live_tests/BER_results_1_{i}.csv", 'r') as file:
            csv_data = np.genfromtxt(file, delimiter=',', dtype=str)
        csv_data = dict(csv_data.tolist())
        link = int(csv_data["link"])
        mezzanine = int(csv_data["mezzanine"])
        time_start = str(csv_data["time_start"])
        rate = float(csv_data["LINE_RATE"])
        bits_transmitted = int(csv_data["RX_RECEIVED_BIT_COUNT"])
        errors = int(csv_data["LOGIC.ERRBIT_COUNT"])
        error_rate = float(csv_data["RX_BER"])
        PATTERN = csv_data["PATTERN"]
        TXPRE = float(csv_data["TXPRE"].split()[0])
        TXPOST = float(csv_data["TXPOST"].split()[0])
        TXDIFFSWING = int(csv_data["TXDIFFSWING"].split()[0])
        RXTERM = int(csv_data["RXTERM"].split()[0])
        insert_BER(db_path,board_ID,link,mezzanine,time_start,rate,bits_transmitted,errors,error_rate,PATTERN,TXPRE,TXPOST,TXDIFFSWING,RXTERM)
   
    # subprocess.run(["./get_gpio.sh"]) # Collect from lab
    with open(f"live_tests/vio_out.csv", 'r') as file:
        csv_data = np.genfromtxt(file,delimiter=',', dtype=str)
        bits_transmitted = int(csv_data[-4][1],base=16)
        time_start = str(csv_data[-3][1])
        for line in csv_data[0:12]:
            mezz = line[0][10]
            link = line[0][12]
            err = int(line[1],base=16)
            insert_BER(db_path,board_ID,link,mezz,time_start,0.160,bits_transmitted,err,(1+err) / bits_transmitted,"PRBS 31-bit",None,None,None,None)


    # subprocess.run(["./get_eyes.sh"]) # Collect from lab
    for i in range(4):
        assert i==int(SFP_plugs[i][3])
        SFP_plug = str(SFP_plugs[i][5]).strip() + "," + str(SFP_plugs[i][7]).strip()
        insert_eye(db_path,board_ID,i,SFP_plug,f"live_tests/Scan_{i}.csv")

    # subprocess.run(["./get_eeprom.sh"]) # Collect from lab



    # subprocess.run(["./get_ddmtd.sh"]) # Collect from lab
    # files saved so now lets load it all in.


    return

DB = ".test.db"
BOARD = "RTM0300001"
# nuke(DB)
create_schema(DB)
populate(DB,BOARD)
read_board(DB,BOARD)
