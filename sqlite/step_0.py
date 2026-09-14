from schema import nuke, mininuke, create_schema
#Dont run this if you aint me

DB = ".test.db"
nuke(DB)
create_schema(DB)

