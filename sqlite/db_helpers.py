import sqlite3

ALL_TABLE_NAMES = ["Boards","BER_tests","eye_diagrams","eeproms","ddmtds"]

def concur(db_path: str, foreign_keys: bool = True) -> None:
    con = sqlite3.connect(db_path)
    if foreign_keys:
        con.execute("PRAGMA foreign_keys = ON")
    else:
        con.execute("PRAGMA foreign_keys = OFF")
    cur = con.cursor()
    return con,cur