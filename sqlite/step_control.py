import sqlite3
from hw_tests import insert_single
from db_helpers import concur
from config import *
import db_dataclasses
import numpy as np
from db_dataclasses import *
import pickle


# con,cur = concur(".test.db")
# cur.execute("DELETE FROM eeproms WHERE slot = '1'")
# con.commit()
# a = cur.execute("SELECT board_ID, link,mezzanine FROM BER_tests").fetchall()
# print(a)
# a = cur.execute("SELECT board_ID, link FROM eye_diagrams").fetchall()
# print(a)
# cur.execute("DELETE FROM Ilas")
# con.commit()
# cur.execute("DELETE FROM BER_tests")