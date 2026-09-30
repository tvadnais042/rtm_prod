from hw_tests import insert_board, get_power, get_user_board

# Config Constants
from config import DB, TESTER_BASE_POWER

board = get_user_board(DB,"RTM")

# base_power_draw = get_power("Base Power Draw (without RTM) [W]: ")

while True:
    with_rtm_power = get_power("Power Draw of RTM in power setup [W]: ")
    if with_rtm_power < TESTER_BASE_POWER:
        print("Must be less or equal to the base power.")
        continue
    else:
        break

print(f"Inserting board {board} {with_rtm_power - TESTER_BASE_POWER:.1}W")
insert_board(DB,board,with_rtm_power-TESTER_BASE_POWER)