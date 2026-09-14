from hw_tests import get_user_board, insert_BER, board_exists, read_BER, read_eyes, read_eeproms
import subprocess, os
import numpy as np

DB = ".test.db"
board = get_user_board(DB,"RTM")

assert board_exists(DB,board), f"{board} not in database. aborting test"

## Instantiate board
# transfer_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"..","payload_transfer_scripts")
# subprocess.run(["bash","transfer_payload.sh","step_3"],cwd=transfer_path)

## Run tests
subprocess.run(["./get_SFP.sh"]) # Collect from RTM
subprocess.run(["./get_eeproms.sh","MMC"])
subprocess.run(["./get_eyes.sh"])
subprocess.run(["./get_ber.sh"])
subprocess.run(["./get_gpio.sh"])

## Read into database
# read_eeproms(DB,board)
# read_eyes(DB,board)
# read_BER(DB,board)
# read_GPIO(DB,board)

## Cleanup intermediates
# subprocess.run(["rm","live_tests/*"]) 