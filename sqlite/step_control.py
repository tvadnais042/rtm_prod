import sqlite3
from hw_tests import concur
from schema import nuke, create_schema
from config import *
con,cur = concur(".test.db")
create_schema(DB)
# a = cur.execute("SELECT board_ID, link,mezzanine FROM BER_tests").fetchall()
# print(a)
# a = cur.execute("SELECT board_ID, link FROM eye_diagrams").fetchall()
# print(a)
# cur.execute("DELETE FROM eye_diagrams")
# cur.execute("DELETE FROM BER_tests")

# con.commit()
