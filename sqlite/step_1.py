from hw_tests import insert_board, get_power, get_user_board

# Config Constants
from config import DB

board = get_user_board(DB,"RTM")

## Do I care about the power draw without the RTM attached?
# base_power_draw = get_power("Base Power Draw (without RTM) [W]: ")

# while True:
#     with_rtm_power = get_power("Power Draw With RTM Attached [W]: ")
#     if with_rtm_power < base_power_draw:
#         print("Must be less or equal to the base power.")
#         continue
#     else:
#         break

# print(f"Inserting board {board} {with_rtm_power - base_power_draw:.1}W")
# insert_board(DB,board,with_rtm_power-base_power_draw)

power_draw = get_power("Power Draw of RTM in tester setup [W]: ")
insert_board(DB,board,power_draw)