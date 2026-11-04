BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS Boards(
    board_ID TEXT NOT NULL PRIMARY KEY,
    type TEXT NOT NULL, 
    version INT NOT NULL,
    num INT NOT NULL,
    power_draw REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS BER_tests(
    board_ID TEXT NOT NULL,
    link INT NOT NULL,
    mezzanine INT NOT NULL,
    time_start TEXT NOT NULL,
    rate REAL NOT NULL,
    bits_transmitted INT NOT NULL,
    errors INT NOT NULL,
    error_rate REAL NOT NULL,
    PATTERN TEXT NOT NULL,
    TXPRE REAL CHECK(mezzanine != 1 OR TXPRE IS NOT NULL),
    TXPOST REAL CHECK(mezzanine != 1 OR TXPOST IS NOT NULL),
    TXDIFFSWING INT CHECK(mezzanine != 1 OR TXDIFFSWING IS NOT NULL),
    RXTERM INT CHECK(mezzanine != 1 OR RXTERM IS NOT NULL),
    GPIO_Q2 BOOLEAN CHECK(mezzanine != 1 OR GPIO_Q2 IS NULL),
    PRIMARY KEY (board_ID, mezzanine, link, GPIO_Q2),
    FOREIGN KEY (board_ID)
        REFERENCES Boards (board_ID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
); 

CREATE TABLE IF NOT EXISTS eye_diagrams(
    board_ID TEXT NOT NULL,
    link INT NOT NULL,
    time_start TEXT NOT NULL,
    time_end TEXT NOT NULL,
    eye_csv BLOB NOT NULL,
    eye_img BLOB,
    SFP_serial TEXT,
    PRIMARY KEY (board_ID,link),
    FOREIGN KEY (board_ID)
        REFERENCES Boards (board_ID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
); 

CREATE TABLE IF NOT EXISTS eeproms(
    board_ID TEXT NOT NULL,
    data_blob BLOB NOT NULL,
    slot INT NOT NULL CHECK(0 <= slot AND slot <= 4),    
    PRIMARY KEY (board_ID,slot),
    FOREIGN KEY (board_ID)
        REFERENCES Boards (board_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
); 

CREATE TABLE IF NOT EXISTS ddmtds(
    board_ID TEXT NOT NULL,
    time_start TEXT NOT NULL,
    data_1 BLOB NOT NULL,
    data_2 BLOB NOT NULL,
    data_3 BLOB NOT NULL,
    shift_hold_us INT NOT NULL,
    step_size_multiplier INT NOT NULL,
    ethernet BOOLEAN,
    PRIMARY KEY (board_ID,shift_hold_us),
    FOREIGN KEY (board_ID)
        REFERENCES Boards (board_ID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
); 

CREATE TABLE IF NOT EXISTS Ilas(
    board_ID TEXT NOT NULL,
    time_start TEXT NOT NULL,
    rate REAL NOT NULL,
    ila_data BLOB NOT NULL,
    FOREIGN KEY (board_ID)
        REFERENCES Boards (board_ID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

COMMIT;