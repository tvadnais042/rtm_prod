from dataclasses import dataclass, fields
from typing import Optional
from schema import concur

_TABLE_NAMES = {
    "Board": "Boards",
    "BER_test": "BER_tests",
    "Eye_diagram": "eye_diagrams",
    "EEPROM": "eeproms",
    "ddmtd": "ddmtds",
}

def insert_single(db_path: str,record) -> None:
    # Insert record object into database. 
    con,cur = concur(db_path)
    class_name = type(record).__name__
    table = _TABLE_NAMES[class_name] #dict lookup
    if table is None:
        ValueError(f"No table mapping for {class_name}.")

    field_names = [f.name for f in fields(record)]
    placeholders = ",".join("?" * len(field_names))
    sql_str = f"INSERT INTO {table}({','.join(field_names)}) VALUES({placeholders})"
    values = tuple(getattr(record,name) for name in field_names)

    cur.execute(sql_str,values)
    con.commit()
    return

@dataclass
class Board:
    board_ID: str
    type: str
    version: int
    num: int
    power_draw: float

@dataclass
class BER_test:
    board_ID: str
    link: int
    mezzanine: int
    time_start: str
    rate: float
    bits_transmitted: int
    errors: int
    error_rate: float
    PATTERN: str
    TXPRE: Optional[float] = None
    TXPOST: Optional[float] = None
    TXDIFFSWING: Optional[int] = None
    RXTERM: Optional[int] = None

@dataclass
class Eye_diagram:
    board_ID: str
    link: int
    time_start: str
    time_end: str
    eye_csv: bytes
    eye_img: Optional[bytes] = None
    SFP_serial: Optional[str] = None

@dataclass
class EEPROM:
    board_ID: str
    data_blob: bytes
    slot: int

@dataclass
class ddmtd:
    board_ID: str
    time_start: str
    data_1: bytes
    data_2: bytes
    data_3: bytes
    shift_hold_us: int
    step_size_multiplier: int
