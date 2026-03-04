import sqlite3

'''
Considerations:

boardID: INT PRIMARY KEY
boardNum: 1,2,3,...50
boardtype: RTM, SFP, SMA, CDR, DDMTD
BER_Category: GPIO, GTH

GPIO_BER: 
    bitsSent, 
    errors, 
    link, 
    rate, 

    plug, TEXT
    nyquist, 
    TX_postcursor, 
    TX_precursor, 
    TX_diff_swing, 
    interposer, 
    RX_term,
GTH_BER: 
    bitsSent, 
    errors, 
    link, 
    rate,

    nyquist, 
    TX_postcursor, 
    TX_precursor, 
    TX_diff_swing, 
    interposer, 
    RX_term,

'''
# Ok its getting gross quick. Lets start from the bottom and work our way up
# Make the blank structure. Populate later. 
# This teaches both structuring and querying.


'''
Simplified Example yeah

'''

def create_database(con, cur):
    cur.execute(
        "CREATE TABLE "
        )

    return



con = sqlite3.connect("test.db")
cur = con.cursor()


# cur.execute("CREATE TABLE count(apple, orange, kiwi)")
# res = cur.execute("SELECT name FROM sqlite_master")
# print(res.fetchall())


# cur.execute("CREATE TABLE BER(\
#     nyquist_sampling)" \
# )

# res = cur.execute("SELECT name FROM sqlite_master")
# print(res.fetchall())

