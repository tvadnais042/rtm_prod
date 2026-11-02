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

def mininuke(db_path: str) -> None:
    '''Delete all rows from tables.'''
    con, cur = concur(db_path)
    for table in ALL_TABLE_NAMES:
        cur.execute(f"DELETE FROM {table}")
    con.commit()

def nuke(db_path: str) -> None:
    '''Drop all tables. Use after updating schema.'''
    con, cur = concur(db_path)
    for table in ALL_TABLE_NAMES:
        cur.execute(f"DROP TABLE {table}")
    con.commit()
