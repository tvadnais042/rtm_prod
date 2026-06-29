import sqlite3

Boards = '''
CREATE TABLE IF NOT EXISTS Boards(
    board_ID TEXT NOT NULL PRIMARY KEY,
    type TEXT NOT NULL, 
    version INT NOT NULL,
    num INT NOT NULL,
    power_draw REAL NOT NULL
) WITHOUT ROWID
'''

BER_tests = '''
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
'''
# mezzanine for non-RTM indicates testing site.
# double meaning dependent on type. Beautiful

eye_diagrams = '''
CREATE TABLE IF NOT EXISTS eye_diagrams(
    board_ID TEXT NOT NULL,
    link INT NOT NULL,
    time_start TEXT NOT NULL,
    time_end TEXT NOT NULL,
    SFP_serial TEXT,
    eye_csv BLOB NOT NULL,
    eye_img BLOB,
    PRIMARY KEY(board_ID,link),
    FOREIGN KEY (board_ID)
        REFERENCES Boards (board_ID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
) WITHOUT ROWID
'''
#SFP serial when we could use the DC plugs? What do I say there?
#UMN_BALUN2_SFP_TX ? 

sfps = '''
CREATE TABLE IF NOT EXISTS sfps(
    board_ID TEXT NOT NULL PRIMARY KEY,
    mezzanine INT NOT NULL,
    testnull INT
) WITHOUT ROWID
'''

ddmtds = '''
CREATE TABLE IF NOT EXISTS ddmtds(
    board_ID TEXT NOT NULL,
    time_start text NOT NULL,
    qflipflop INT NOT NULL,
    FOREIGN KEY (board_ID)
        REFERENCES Boards (board_ID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
'''

ALL_TABLES = [Boards, BER_tests, eye_diagrams, sfps]
ALL_TABLE_NAMES = ["Boards","BER_tests","eye_diagrams","sfps"]

def concur(db_path: str, foreign_keys: bool = True) -> None:
    con = sqlite3.connect(db_path)
    if foreign_keys:
        con.execute("PRAGMA foreign_keys = ON")
    else:
        con.execute("PRAGMA foreign_keys = OFF")
    cur = con.cursor()
    return con,cur

def create_schema(db_path: str) -> None:
    '''Create All Tables'''
    con, cur = concur(db_path)
    for statement in ALL_TABLES:
        cur.execute(statement)
    con.commit()    
    return

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
