from dataclasses import dataclass
from typing import Optional

_TABLE_NAMES = {
    "Board": "Boards",
    "BER_test": "BER_tests",
    "Eye_diagram": "eye_diagrams",
    "EEPROM": "eeproms",
    "ddmtd": "ddmtds",
}

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
    mezzanin: int
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
    SFP_serial: Optional[str] = None
    eye_csv: bytes
    eye_img: Optional[bytes] = None

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
    shift_value: float
