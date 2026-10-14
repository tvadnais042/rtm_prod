import sqlite3
from hw_tests import concur, insert_single
from schema import nuke, create_schema, mininuke, concur
from config import *
import db_dataclasses

con,cur = concur(".test.db")
nuke(DB)
create_schema(DB)
# a = cur.execute("SELECT board_ID, link,mezzanine FROM BER_tests").fetchall()
# print(a)
# a = cur.execute("SELECT board_ID, link FROM eye_diagrams").fetchall()
# print(a)
# cur.execute("DELETE FROM eye_diagrams")
# cur.execute("DELETE FROM BER_tests")

# con.commit()
