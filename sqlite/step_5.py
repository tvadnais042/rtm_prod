from hw_tests import get_user_board, get_power, board_exists, insert_board

# Config Constants
from config import DB

def board_helper(message_string, base_power_draw):
    '''. Do Not use elsewhere.'''
    while True:
        new_power_draw = get_power(message_string)
        if new_power_draw < base_power_draw:
            print("Power Should Not have decreased.")
            continue
        else:
            break
    return new_power_draw

board = get_user_board(DB,"RTM")

assert board_exists(DB,board), f"{board} not in database. aborting test"

BOARD_NUM = board[5:10]
base_power_draw = board_helper("Power Draw of unpopulated RTM (W): ",0)

power_draw = board_helper("Power Draw with DDMTD Added (W): ",base_power_draw)
insert_board(DB,"DDMTD02"+BOARD_NUM,power_draw-base_power_draw)
base_power_draw = power_draw
power_draw = board_helper("Power Draw After Attaching SFP (W): ",base_power_draw)
insert_board(DB,"SFP02"+BOARD_NUM,power_draw-base_power_draw)
base_power_draw = power_draw
power_draw = board_helper("Power Draw After Attaching SMA (W): ",base_power_draw)
insert_board(DB,"SMA02"+BOARD_NUM,power_draw-base_power_draw)
base_power_draw = power_draw
power_draw = board_helper("Power Draw After Attaching CDR (W): ",base_power_draw)
insert_board(DB,"CDR02"+BOARD_NUM,power_draw-base_power_draw)

