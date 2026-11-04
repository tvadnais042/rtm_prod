from hw_tests import parse_board_ID, board_exists
from db_helpers import concur
import pickle
from config import *
import numpy as np

PASS, FAIL, NOT_RUN = 1, 0, -1
STATUS_LABELS = {PASS: "PASS", FAIL: "FAIL", NOT_RUN: "NOT RUN"}

# Rows of corn and wheat

def power_check(DB,board,criterion):
    _,cur = concur(DB)
    data = cur.execute(f"SELECT power_draw FROM Boards WHERE board_ID = '{board}'").fetchone()
    if data == None:
        return [(NOT_RUN, "Power", None)]
    if data[0] > criterion:
        return [(PASS, "Power", None)]
    return [(FAIL, "Power", None)]

def eeprom_check(DB,board,eeproms:list|int):
    _,cur = concur(DB)
    if type(eeproms)==list:
        data = cur.execute(f"SELECT slot FROM eeproms WHERE board_ID = '{board}'").fetchall() #breaks if not checking all
        data = [x[0] for x in data]
        if len(data)==len(eeproms):
            return [(PASS, "EEPROMs", None)]
        return [(FAIL, "EEPROMs", f"EEPROM {[x for x in eeproms if x not in data]} missing. ")]
    elif type(eeproms)==int:
        data = cur.execute(f"SELECT slot FROM eeproms WHERE board_ID = '{board}' AND slot = '{eeproms}'").fetchone()
        if data == None:
            return [(FAIL, "EEPROMs", f"EEPROM {eeproms} missing. ")]
        if eeproms == data[0]:
            return [(PASS, "EEPROMs", None)]
        return [(FAIL, "EEPROMs", f"EEPROM {eeproms} missing. ")]

def GTH_BER_check(DB,board):
    _,cur = concur(DB)
    results = []
    minimum_bits_pass = int(1/float(BER_PRECISION_SFP))
    for i in range(4):
        test_str = f"High-Speed BER Link {i}"
        data = cur.execute(f"SELECT errors,bits_transmitted FROM BER_tests WHERE board_ID = '{board}' AND link = '{i}' AND mezzanine = '1'").fetchone()
        if data == None:
            results.append((NOT_RUN, test_str, None))
            continue
        elif (data[0] == 0) and (data[1] > minimum_bits_pass):
            results.append((PASS, test_str, None))
        else:
            results.append((FAIL, test_str, f"errors({data[0]}), bits({data[1]})"))
    return results

def eye_check(DB,board):
    _,cur = concur(DB)
    results = []
    for i in range(4):
        test_str = f"Eye Link {i}"
        data = cur.execute(f"SELECT eye_csv FROM eye_diagrams WHERE board_ID = '{board}' AND link = '{i}'").fetchone()
        if data == None:
            results.append((NOT_RUN, test_str, None))
            continue
        data = pickle.loads(data[0])
        if float(data["Horizontal Percentage"]) > 35 and float(data["Vertical Percentage"]) > 35:
            results.append((PASS, test_str, None))
        else:
            results.append((FAIL, test_str, None))
    return results

def GPIO_check(DB,board,mezzes,links):
    _,cur = concur(DB)
    results = []
    minimum_bits_pass = int(1/float(GPIO_PRECISION_SMA))

    for mezz in mezzes:
        for link in links:
            test_str = f"GPIO M{mezz}_L{link}"
            data = cur.execute(f"SELECT errors,bits_transmitted FROM BER_tests WHERE board_ID = '{board}' AND link = '{link}' AND mezzanine = '{mezz}' and GPIO_Q2 = '0'").fetchone()
            data_Q2 = cur.execute(f"SELECT errors,bits_transmitted FROM BER_tests WHERE board_ID = '{board}' AND link = '{link}' AND mezzanine = '{mezz}' and GPIO_Q2 = '1'").fetchone()
            if (data == None) or (data_Q2 == None):
                results.append((NOT_RUN, test_str, None))
            elif ((data[0] == 0) and (data[1] > minimum_bits_pass)) or ((data_Q2[0] == 0) and (data_Q2[1] > minimum_bits_pass)):
                results.append((PASS, test_str, None))
            else:
                results.append((FAIL, test_str, f"Q1 {data}, Q2 {data_Q2}"))
    return results

def ila_check(DB,board,nets):
    _,cur = concur(DB)
    data = cur.execute(f"SELECT rate,ila_data FROM Ilas WHERE board_ID = '{board}'").fetchone()
    if data == None:
        return [(NOT_RUN, "ILA test", None)]
    if data[0] != GPIO_RATE:
        return [(FAIL, "ILA test", f"Data Rate Not {GPIO_RATE}")]
    err_msg = []
    ila_data = pickle.loads(data[1])
    for net in nets:
        errors = []
        for lag in range(0, 16):
            n = len(ila_data["prbs_data"]) - lag
            errors.append(np.sum(ila_data["prbs_data"][:n] != ila_data[net][lag:lag+n]))
        if np.min(errors) != 0:
            err_msg.append(net)
    if err_msg == []:
        return [(PASS, "ILA test", None)]
    return [(FAIL, "ILA test", f"errors in {err_msg}")]

def ethernet_check(DB,board):
    _,cur = concur(DB)
    data = cur.execute(f"SELECT ethernet FROM ddmtds WHERE board_ID = '{board}'").fetchone()
    if data == None:
        return [(NOT_RUN, "Ethernet", None)]
    if data[0]:
        return [(PASS, "Ethernet", None)]
    return [(FAIL, "Ethernet", None)]

def ddmtd_check(DB,board):
    _,cur = concur(DB)
    # Pull up analysis code? 
    # Check shift amount is consistent, -> find metric from that 
    # Check Qs individually
    # data = cur.execute(f"")

    return

#=================================#
# Magic numbers subject to change #
#=================================#

def board_status(DB:str,board:str):
    """Run every check for the board's type and return the list of result tuples."""
    TYPE,_,_ = parse_board_ID(board)
    assert board_exists(DB,board), f"Board {board} is not registered. "
    results = []

    if TYPE == "RTM":
        results += power_check(DB,board,0.1)
        results += GTH_BER_check(DB,board)
        results += eye_check(DB,board)
        results += GPIO_check(DB,board,[2,3,4],[0,1,2,3])
    elif TYPE == "SFP":
        results += power_check(DB,board,0.1)
        results += eeprom_check(DB,board,[0,1,2,3,4])
        results += GTH_BER_check(DB,board)
        results += eye_check(DB,board)
    elif TYPE == "SMA":
        results += power_check(DB,board,0.1)
        results += eeprom_check(DB,board,0)
        results += GPIO_check(DB,board,[2],[0,1,2,3])
    elif TYPE == "MMC":
        results += power_check(DB,board,0.1)
        results += eeprom_check(DB,board,0)
    elif TYPE == "CDR":
        results += power_check(DB,board,0.1)
        results += eeprom_check(DB,board,[0,1,2,3,4])
        results += GPIO_check(DB,board,[3],[0,1,2,3])
        results += ila_check(DB,board,["MEZZ3_RX_synced_211"])
    elif TYPE == "DDMTD":
        results += power_check(DB,board,0.1)
        # results += ddmtd_check(DB,board)
        results += ethernet_check(DB,board)
        results += eeprom_check(DB,board,0)
    return results


#=================================#
#            Printing             #
#=================================#

def _table_row(name,status_label,err,name_w,status_w):
    return f"| {name:<{name_w}} | {status_label:<{status_w}} | {err or ''}"
 
def print_results(board):
    results = board_status(DB,board)
    passed = sum(1 for status,_,_ in results if status == PASS)
    print(f"{board} status: {passed}/{len(results)} tests passed")
    
    # set page rule
    name_w = max([len("Test")] + [len(name) for _,name,_ in results])
    status_w = max(len(label) for label in STATUS_LABELS.values())
    rule = f"|-{'-'*name_w}-|-{'-'*status_w}-|-{'-'*5}" # you better hope you got monospacing
 
    print(_table_row("Test","Status","Error",name_w,status_w))
    print(rule)
    for status,name,err in results:
        print(_table_row(name,STATUS_LABELS[status],err if status != PASS else None,name_w,status_w))
    print()

print_results("SFP0200001")
print_results("SMA0200001")
print_results("CDR0200001")
print_results("MMC0000001")
