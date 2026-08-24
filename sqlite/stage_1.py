from schema import create_schema
from hw_tests import board_exists, insert_board

create_schema(".test.db")

while True:
    board = input("RTM serial code? ")
    print(board_exists(".test.db",board))
    insert_board(board)
    print(board_exists(".test.db",board))
    if board_exists(".test.db",board):
        break

print("congrats!!")


