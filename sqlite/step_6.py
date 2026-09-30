from hw_tests import get_user_board, board_exists, read_eeproms, read_eyes, read_BER, read_GPIO
import os, subprocess

# Config Constants
from config import *

# Get Board number and Sanity check
board = get_user_board(DB,"RTM")
board_NUM = board[5:10]
assert board_exists(DB,board), f"{board} not in database. aborting test"
assert board_exists(DB,"SFP02"+board_NUM), f"SFP not in database."
assert board_exists(DB,"SMA02"+board_NUM), f"SMA not in database."
assert board_exists(DB,"CDR02"+board_NUM), f"CDR not in database."
assert board_exists(DB,"DDMTD02"+board_NUM), f"DDMTD not in database."
assert board_exists(DB,"MMC00"+board_NUM), f"MMC not in database."

#===================
# TEST FUNCTION Deleter
#===================
from hw_tests import concur
con,cur = concur(DB)
cur.execute("DELETE FROM ddmtds")
con.commit()
#====================

# Instantiate tester
# transfer_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"..","payload_transfer_scripts")
# subprocess.run(["bash","transfer_payload.sh","step_6"],cwd=transfer_path)
# TODO make payload 6 with CDR and DDMTD in mind.

# # Collect EEPROMS
# subprocess.run(["./get_eeproms.sh","all","0"])

# # Read EEPROM data
# for i in range(5):
#     read_eeproms(DB,"SFP02"+board_NUM,i)
#     read_eeproms(DB,"CDR02"+board_NUM,i)
# read_eeproms(DB,"SMA02"+board_NUM,0)
# read_eeproms(DB,"DDMTD02"+board_NUM,0)
# read_eeproms(DB,"MMC00"+board_NUM,0)

# # Run tests
# subprocess.run(["./get_eyes.sh",f"{EYE_PRECISION_SFP}"])
# subprocess.run(["./get_ber.sh",f"{BER_PRECISION_SFP}"])
# subprocess.run(["./get_gpio.sh",f"{GPIO_PRECISION_SMA}"])
subprocess.run(["./get_ddmtds.sh"]) #this is fake lol

# TODO Validate GPIO test IN LAB

# Read into database
# read_eyes(DB,"SFP02"+board_NUM)
# read_BER(DB,"SFP02"+board_NUM)
# read_GPIO(DB,"SMA02"+board_NUM)
# read_DDMTD(DB,"")

# Cleanup intermediates
subprocess.run(["rm","live_tests/*"])

