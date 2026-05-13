import sqlite3
import re
import numpy as np
import subprocess
from datetime import datetime

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

def create_schema(db_path):
    con, cur = concur(db_path)

    cur.execute('''
    CREATE TABLE IF NOT EXISTS Boards(
        board_ID TEXT NOT NULL PRIMARY KEY,
        type TEXT NOT NULL, 
        version INT NOT NULL,
        num INT NOT NULL
    ) WITHOUT ROWID
    ''')

    cur.execute('''
    CREATE TABLE IF NOT EXISTS BER_tests(
        board_ID TEXT NOT NULL,
        link INT NOT NULL,
        mezzanine INT NOT NULL,
        time_start TEXT NOT NULL,
        rate REAL NOT NULL,
        bits_transmitted INT NOT NULL,
        errors INT NOT NULL,
        error_rate REAL NOT NULL,
        PATTERN TEXT NOT NULL,
        TXPRE REAL CHECK(mezzanine != 1 OR TXPRE IS NOT NULL),
        TXPOST REAL CHECK(mezzanine != 1 OR TXPOST IS NOT NULL),
        TXDIFFSWING INT CHECK(mezzanine != 1 OR TXDIFFSWING IS NOT NULL),
        RXTERM INT CHECK(mezzanine != 1 OR RXTERM IS NOT NULL),
        PRIMARY KEY (board_ID, mezzanine, link),
        FOREIGN KEY (board_ID)
            REFERENCES Boards (board_ID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
    ) WITHOUT ROWID
    ''')
    #mezzanine for non-RTM indicates testing site.
    #double meaning dependent on type. Beautiful

    cur.execute('''
    CREATE TABLE IF NOT EXISTS eye_diagrams(
        board_ID TEXT NOT NULL,
        link INT NOT NULL,
        time_start TEXT NOT NULL,
        time_end TEXT NOT NULL,
        SFP_serial TEXT NOT NULL,
        eye_csv BLOB NOT NULL,
        eye_img BLOB,
        PRIMARY KEY(board_ID,link),
        FOREIGN KEY (board_ID)
            REFERENCES Boards (board_ID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
    ) WITHOUT ROWID
    ''')
    #SFP serial when we could use the DC plugs? What do I say there?
    #UMN_BALUN2_SFP_TX ? 

    cur.execute('''
    CREATE TABLE IF NOT EXISTS eeproms(
        board_ID TEXT NOT NULL PRIMARY KEY,
        mezzanine INT NOT NULL,
        testnull INT
    ) WITHOUT ROWID
    ''')
    return

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

def nuke_database(db_path, mini=False):
    con, cur = concur(db_path)
    if mini:
        cur.execute("DELETE FROM Boards")
        cur.execute("DELETE FROM BER_tests")
        cur.execute("DELETE FROM eye_diagrams")
        cur.execute("DELETE FROM eeproms")
    else:
        cur.execute("DROP TABLE IF EXISTS Boards")
        cur.execute("DROP TABLE IF EXISTS BER_tests")
        cur.execute("DROP TABLE IF EXISTS eye_diagrams")
        cur.execute("DROP TABLE IF EXISTS eeproms")
    con.commit()
    
    return

def insert_board(db_path, board_ID):
    con, cur = concur(db_path)

    TYPE, VERSION, NUM = parse_board_ID(board_ID)
    cur.execute('''
        INSERT INTO Boards(board_ID, type, version, num)
        VALUES(?,?,?,?)''',(board_ID,TYPE,VERSION,NUM))
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
    df = cur.execute(f"SELECT board_ID, link, time_start, time_end FROM eye_diagrams WHERE board_ID = '{board_ID}'")
    print(f"{board_ID}")
    print("Eyes: ID, Link, Start, End: ")
    print(*df.fetchall(), sep='\n')
    df = cur.execute(f"SELECT * FROM BER_tests WHERE board_ID = '{board_ID}'")
    print("BER: ID, Mezzanine, Link")
    print(*df.fetchall(), sep='\n')

    return

def get_SFP_plugs():
    # TODO connect to actual board
    # Since I dont think anything changes if I program the PLL,
    # Start the server and have a dedicated python file for the action.
    return (("fakeNotReal"),("fakeNotReal"),("fakeNotReal"),("fakeNotReal"))

def populate(db_path, board_ID):
    try:
        insert_board(db_path,board_ID)
    except:
        pass
    
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
        insert_BER("test.db","RTM0300001",link,mezzanine,time_start,rate,bits_transmitted,errors,error_rate,PATTERN,TXPRE,TXPOST,TXDIFFSWING,RXTERM)
    
    # subprocess.run(["./get_gpio.sh"]) # Collect from lab
    # TODO reset the counter before you start recording
    with open(f"live_tests/vio_out.csv", 'r') as file:
        csv_data = np.genfromtxt(file,delimiter=',', dtype=str)
        bits_transmitted = int(csv_data[-2][1],base=16)
        time_start = str(csv_data[-1][1])
        for line in csv_data[0:-3]:
            mezz = line[0][10]
            link = line[0][12]
            err = int(line[1],base=16)
            insert_BER("test.db","RTM0300001",link,mezz,time_start,0.160,bits_transmitted,err,(1+err) / bits_transmitted,"PRBS 31-bit",None,None,None,None)

    # subprocess.run(["./get_eyes.sh"]) # Collect from lab
    SFP_plugs = get_SFP_plugs()
    
    for i in range(4):
        insert_eye(db_path,board_ID,i,SFP_plugs[i],f"live_tests/Scan_{i}.csv")

    return


# So you dont gotta worry about duplicate yet
nuke_database("test.db",mini=False)
create_schema("test.db")
populate("test.db","RTM0300001")
read_board("test.db","RTM0300001")
