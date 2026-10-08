from hw_tests import get_user_board, board_exists, read_eeproms, read_eyes, read_BER, read_GPIO, read_DDMTD
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
# from hw_tests import concur
# con,cur = concur(DB)
# cur.execute("DELETE FROM ddmtds")
# cur.execute("DELETE FROM BER_tests")
# cur.execute("DELETE FROM eye_diagrams")
# cur.execute("DELETE FROM eeproms")
# con.commit()
#================================

# Instantiate tester
transfer_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"..","payload_transfer_scripts")
subprocess.run(["bash","transfer_payload.sh","step_6"],cwd=transfer_path)
# TODO make payload 6 with CDR and DDMTD in mind.

# Collect EEPROMS ===============
subprocess.run(["./get_eeproms.sh","all","0"])

# Read EEPROM data ==============
for i in range(5):
    read_eeproms(DB,"SFP02"+board_NUM,i)
    read_eeproms(DB,"CDR02"+board_NUM,i)
read_eeproms(DB,"SMA02"+board_NUM,0)
read_eeproms(DB,"DDMTD02"+board_NUM,0)
read_eeproms(DB,"MMC00"+board_NUM,0)

# Run tests =====================
subprocess.run(["./get_ddmtd.sh"]) 
subprocess.run(["./get_eyes.sh",EYE_PRECISION_SFP,transfer_path+"/payloads/step_6/"]) #Running a tcl script will require a board power cycle
subprocess.run(["./get_ber.sh",BER_PRECISION_SFP,transfer_path+"/payloads/step_6/"]) #I dont know why but it is so.
subprocess.run(["./get_gpio.sh",GPIO_PRECISION_SMA,transfer_path+"/payloads/step_6/"])

# TODO Validate GPIO test IN LAB

# Read into database ============
read_eyes(DB,"SFP02"+board_NUM)
read_BER(DB,"SFP02"+board_NUM)
read_GPIO(DB,"SMA02"+board_NUM)
read_DDMTD(DB,"DDMTD02"+board_NUM,"live_tests/0",0)
read_DDMTD(DB,"DDMTD02"+board_NUM,"live_tests/1",-1000000)

# Cleanup intermediates
subprocess.run(["rm","-rf","live_tests/*"])

