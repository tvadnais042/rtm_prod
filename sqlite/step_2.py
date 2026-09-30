from hw_tests import parse_board_ID, get_power, concur, get_user_board, insert_board, board_exists

# Config Constants
from config import DB, TESTER_BASE_POWER

board = get_user_board(DB,"MMC")

_,_,NUM = parse_board_ID(board)
_, cur = concur(DB)
base_power_draw = cur.execute(f"SELECT power_draw FROM Boards WHERE (NUM = '{NUM}') AND (TYPE = 'RTM')").fetchone()

base_power_draw = float(base_power_draw[0]) + TESTER_BASE_POWER
print(f"Base Power Draw {base_power_draw}") 

while True:
    power_draw = get_power("Power Draw with MMC (W): ")
    if power_draw < base_power_draw:
        print("Must be less or equal to the base RTM power.")
        continue
    else:
        break

insert_board(DB,board,power_draw-base_power_draw)

