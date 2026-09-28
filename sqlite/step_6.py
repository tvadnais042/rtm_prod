from hw_tests import get_user_board, board_exists, read_eeproms, read_eyes, read_BER, read_GPIO
import os, subprocess

# Config Constants
from config import *

#============
# RESET HELPER FOR TESTING
from hw_tests import concur
from schema import create_schema
#============

# Get Board number and Sanity check
board = get_user_board(DB,"RTM")
assert board_exists(DB,board), f"{board} not in database. aborting test"
assert board_exists(DB,"SFP02"+board[5:10]), f"SFP not in database."
assert board_exists(DB,"SMA02"+board[5:10]), f"SMA not in database."
assert board_exists(DB,"CDR02"+board[5:10]), f"CDR not in database."
assert board_exists(DB,"DDMTD02"+board[5:10]), f"DDMTD not in database."
assert board_exists(DB,"MMC00"+board[5:10]), f"DDMTD not in database."


# Instantiate tester
# transfer_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"..","payload_transfer_scripts")
# subprocess.run(["bash","transfer_payload.sh","step_6"],cwd=transfer_path)
# TODO make payload 6 with CDR and DDMTD in mind.


# Collect EEPROMS
for i in range(5):
    subprocess.run(["./get_eeproms.sh","SFP",f"{i}"])
    subprocess.run(["./get_eeproms.sh","CDR",f"{i}"])
subprocess.run(["./get_eeproms.sh","SMA","0"])
subprocess.run(["./get_eeproms.sh","DDMTD","0"])
subprocess.run(["./get_eeproms.sh","MMC","0"])

# Read EEPROM data
for i in range(5):
    read_eeproms(DB,"SFP02"+board[5:10],i)
    read_eeproms(DB,"CDR02"+board[5:10],i)
read_eeproms(DB,"SMA02"+board[5:10],0)
read_eeproms(DB,"DDMTD02"+board[5:10],0)
read_eeproms(DB,"MMC00"+board[5:10],0)

# Run tests
# subprocess.run(["./get_eyes.sh"])
# subprocess.run(["./get_ber.sh"])
# subprocess.run(["./get_gpio.sh"])
# TODO Validate GPIO test IN LAB
# TODO will this get only the present GPIO? I only need it for SMA and CDR right?

# Read into database
# read_eyes(DB,board)
# read_BER(DB,board)
# read_GPIO(DB,board)

# Cleanup intermediates
# subprocess.run(["rm","live_tests/*"]) 