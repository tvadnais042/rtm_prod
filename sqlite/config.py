# Database filename
DB = ".test.db"

# Base power of the tester setup before attaching RTM or anything else.
# Only update this between testing a set of boards. It shouldn't normally change.
TESTER_BASE_POWER = 0.1

# Testing parameters -- NOT NOT CHANGE DURING TESTING! -- 
BER_PRECISION_RTM = "1e-10"
EYE_PRECISION_RTM = "1e-8"
GPIO_PRECISION_RTM = "1e-8"

BER_PRECISION_SFP = "1e-10" # become 1e-15
EYE_PRECISION_SFP = "1e-8" # become 1e-10
GPIO_PRECISION_SMA = "1e-8" # become 1e-10
