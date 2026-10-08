from hw_tests import get_user_board, board_exists, read_BER, read_eyes, read_GPIO
import subprocess, os
import numpy as np

# Config Constants
from config import *

board = get_user_board(DB,"RTM")
assert board_exists(DB,board), f"{board} not in database. aborting test"

# Instantiate tester 
transfer_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"..","payload_transfer_scripts")
subprocess.run(["bash","transfer_payload.sh","step_3"],cwd=transfer_path)

# Run tests
subprocess.run(["./get_eyes.sh",EYE_PRECISION_RTM,transfer_path+"/payloads/step_3/"])
subprocess.run(["./get_ber.sh",BER_PRECISION_RTM,transfer_path+"/payloads/step_3/"])
subprocess.run(["./get_gpio.sh",GPIO_PRECISION_RTM,transfer_path+"/payloads/step_3/"])
# TODO Validate GPIO test IN LAB

# Read into database
read_eyes(DB,board)
read_BER(DB,board)
read_GPIO(DB,board)

# Cleanup intermediates
subprocess.run(["rm","live_tests/*"]) 