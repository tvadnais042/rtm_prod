#include <stdio.h>
#include <string.h>
#include "pico/stdlib.h"
#include "pico/bootrom.h"
#include "hardware/i2c.h"
#include "hardware/clocks.h"
#include "hardware/watchdog.h"

#include "pll_conf/Si5344H-RevD-Registers_freerun.h"
// #include "pll_conf/Si5344H-RevD-Registers_in0.h"
// #include "pll_conf/Si5344H-RevD-Registers_in1.h"


#define SDA_PIN 2
#define SCL_PIN 3
#define D7_PIN 7
#define D9_PIN 9
#define LED_PIN 11

// 0x20?
// 0x21?
//#define ADC_ADDR 0x40
#define SFPA0H 0x50 
#define MMC_ADDR 0x51
#define PLL_ADDR 0x68 // address of PLL on RTMV2
#define DATA_BUS_SELECT 0x70
#define MEZZ_SELECT 0x72
#define SFP_SELECT 0x73

#define CMD_BUF_SIZE 64 
#define READY_PROMPT "OK\n"
#define MAIN_SCREED "MAIN: (R)eboot, (S)hiftLarge, (s)hift_20ms, (c)onfig_pll, (l)os_check, (t)alk, sc(a)n_bus, (E)eprom\n"

void process_command(const char* cmd);
void config_pll();
bool scan_bus();
void check_los();
uint32_t step_fs(uint32_t us);
void inspect_SFP(uint8_t mezz, uint8_t link);
void inspect_EEPROM();
void flash_LED(uint32_t ms);
void pulse_LED(uint32_t ms);

void main()
{
    stdio_init_all(); //init USB serial
    set_sys_clock_khz(125000,true);
    
    printf("USB Connected\n");
    if (watchdog_caused_reboot()){
        printf("Watchdog Caused Reboot :(\n");
    }

    // Init I2C pins
    i2c_init(i2c1,100000);
    gpio_set_function(SDA_PIN, GPIO_FUNC_I2C);
    gpio_set_function(SCL_PIN, GPIO_FUNC_I2C);
    gpio_pull_up(SDA_PIN);
    gpio_pull_up(SCL_PIN);

    // Force D7/D9 pin low before searching
    // Sets muxer address to 0x70 = (0b11100(D9)(D7))
    gpio_init(D7_PIN);
    gpio_init(D9_PIN);
    gpio_set_dir(D7_PIN,true);
    gpio_set_dir(D9_PIN,true);
    gpio_put(D7_PIN,false);
    gpio_put(D9_PIN,false);

    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    
    char cmd[CMD_BUF_SIZE];
    int cmd_pos = 0;
    printf(READY_PROMPT);
    fflush(stdout);
    while (true) {
        int c = stdio_getchar_timeout_us(1000);
        if (c == PICO_ERROR_TIMEOUT) continue; //is this even a value?
        if (c == '\n' || c == '\r') {
            if (cmd_pos > 0) {
                cmd[cmd_pos] = '\0';
                process_command(cmd);
                cmd_pos = 0;
            }
        }
        else if (cmd_pos < (CMD_BUF_SIZE - 1)) {
            cmd[cmd_pos] = (char)c;
            cmd_pos++;
        }
    }
   
    reset_usb_boot(0,0); // enable BOOTSEL // BANG!
}

void process_command(const char* cmd) {
    
    // Acknowledge the received command for host.
    printf("ACK: %s\n",cmd);

    if (strcmp(cmd,"R") == 0) {
        printf("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH!!!!!!!!!!!!");
        printf("PLEASE DONT KILL ME I PROMISE I WILL PERFORM WHAT I NEED TO JUST DONT KILL ME PLEASE I CANT DIE NOT NOW NOT LIKE THIS!!!!");
        sleep_ms(100);
        reset_usb_boot(0,0); // enable BOOTSEL // BANG!
    }
    else if (strcmp(cmd,"Reboot") == 0) {
        reset_usb_boot(0,0); // enable BOOTSEL but faster for host.py
    }
    else if ((strcmp(cmd,"s") == 0) || ((strcmp(cmd,"shift") == 0))){
        uint32_t dt = step_fs(20000);
    }
    else if ((strcmp(cmd,"S") == 0) || (strcmp(cmd,"shiftLarge") == 0)) {
        uint32_t dt = step_fs(1000000);
    }
    else if ((strcmp(cmd,"t") == 0) || (strcmp(cmd,"talk") == 0)) {
        ;
    }
    else if ((strcmp(cmd,"m") == 0) || (strcmp(cmd,"main") == 0) || (strcmp(cmd,"MAIN") == 0)) {
        printf(MAIN_SCREED);
    }
    else if ((strcmp(cmd,"l") == 0) || (strcmp(cmd,"check_loss") == 0)) {
        check_los();
    }
    else if ((strcmp(cmd,"a") == 0) || (strcmp(cmd,"scan_bus") == 0)) {
        scan_bus();
    }
    else if ((strcmp(cmd,"c") == 0) || (strcmp(cmd,"config_pll") == 0)) { 
        config_pll();
        pulse_LED(30);
    }
    else if ((strcmp(cmd,"SFP") == 0) || (strcmp(cmd,"eeprom_sfp") == 0)) {
        for (int mezz=0; mezz<4; mezz++) {
            for (int link=0; link<4; link++) {
                inspect_SFP(mezz,link);
            }
        }
    }
    else if ((strcmp(cmd,"eeprom") == 0) || (strcmp(cmd,"E") == 0)) {
        inspect_EEPROM();
    }
    else {
        printf("ERR: Unknown command %s\n",cmd);
    }
    
    printf(READY_PROMPT);
}

bool scan_bus() {
    printf("Beginning I2C Scan\n");
    bool pllFlag = false;
    for (uint8_t addr; addr < 128; addr++) {
        uint8_t rxdata;
        int ret = i2c_read_blocking_until(i2c1,addr, &rxdata, 1, false, make_timeout_time_ms(10)); //using i2c1 for pin 2,3
        if (ret >= 0) {
            printf("Found at 0x%02x\n",addr);
            if (addr==PLL_ADDR){
                pllFlag = true;
            }
        }
    }
    printf("Ending I2C Scan\n");
    return pllFlag;
}

void config_pll() {
    // Change pllconfig to use 
    // password for the windows laptop in lab: intel123

    printf("Configuring PLLs\n");

    i2c_write_blocking_until(i2c1,DATA_BUS_SELECT,(uint8_t []){0x1},1,false, make_timeout_time_ms(50)); // opens 0x72 mezz mux
    i2c_write_blocking_until(i2c1,MEZZ_SELECT,(uint8_t []){0x8},1,false, make_timeout_time_ms(50)); // selects mezz4 (0x68)
    
    uint8_t page_now; // Wont know until first write

    // Preamble
    for (int i=0; i < 3; i++) {
        // printf("Reg %04X Val %02X \n",si5345_revd_registers[i].address, si5345_revd_registers[i].value);
    
        uint8_t page[2] = {0x01,si5344h_revd_registers[i].address >> 8};
        uint8_t data[2] = {si5344h_revd_registers[i].address & 0xff, si5344h_revd_registers[i].value}; 
        i2c_write_blocking(i2c1,PLL_ADDR,page,2,false);
        page_now = page[1];
        i2c_write_blocking(i2c1,PLL_ADDR,data,2,false);
    }

    sleep_ms(300);

    // Body + Postamble
    for (int i=3; i < SI5344H_REVD_REG_CONFIG_NUM_REGS; i++) {
        // printf("|%04X %02X",si5345_revd_registers[i].address, si5345_revd_registers[i].value);
        uint8_t page[2] = {0x01,si5344h_revd_registers[i].address >> 8};
        if (page_now != page[1]) {
            i2c_write_blocking(i2c1,PLL_ADDR,page,2,false);
            page_now = page[1];
        }
        uint8_t data[2] = {si5344h_revd_registers[i].address & 0xff, si5344h_revd_registers[i].value}; 
        i2c_write_blocking(i2c1,PLL_ADDR,data,2,false);

        // Check writes
        uint8_t readout;
        i2c_write_blocking(i2c1,PLL_ADDR,&data[0],1,true);
        i2c_read_blocking(i2c1,PLL_ADDR,&readout,1,false);
        if (readout != data[1] && i < SI5344H_REVD_REG_CONFIG_NUM_REGS-5) {
            printf("\nERROR! (%d) Reg %04X Val %02X != %02X\n",i, si5344h_revd_registers[i].address, data[1], readout);
        }
    }

    printf("End pll Config\n");
}

void check_los(){
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x01,0x00},2,false); // Write page
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x1C, 0x01},2,false);
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x12, 0x00},2,false);
    for (int i=0; i < 20; i++){
        uint8_t input_loc;
        uint8_t dspll_loc;
        uint8_t dspll_loc_sticky;
        i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x0D},1,true);
        i2c_read_blocking(i2c1,PLL_ADDR,&input_loc,1,false);

        i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x0E},1,true);
        i2c_read_blocking(i2c1,PLL_ADDR,&dspll_loc,1,false);

        i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x12},1,true);
        i2c_read_blocking(i2c1,PLL_ADDR,&dspll_loc_sticky,1,false);
        input_loc = input_loc & 0x0F;
        dspll_loc = dspll_loc & 0x01;
        dspll_loc_sticky = dspll_loc_sticky & 0x01;
        printf("Input Loc: %d, DSPLL Loc: %d, Sticky Loc: %d\n",input_loc,dspll_loc,dspll_loc_sticky);
        
        gpio_put(LED_PIN,true);
        sleep_ms(100);
        gpio_put(LED_PIN,false);
        sleep_ms(100);
    } 
}

uint32_t step_fs(uint32_t us) {
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x01,0x03},2,false); // write page
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x39,0b1011},2,false); // set mask

    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x47,0x64},2,false); // set the change high baby
    
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x01,0x00},2,false); // write page
    uint32_t t0 = time_us_32();
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x1D,0b01},2,false); // lets go shifting!!
    sleep_us(us);
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x1D,0b10},2,false); // lets go shifting!!
    uint32_t dt = time_us_32() - t0;

    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x01,0x03},2,false); // write page2
    i2c_write_blocking(i2c1,PLL_ADDR,(uint8_t[]){0x47,0x00},2,false); // get rid of that change baby
    

    printf("STEP Function Time = %li.%.6li s\n", dt/1000000, dt%1000000);
    sleep_ms(2);
    return dt;
}

void inspect_EEPROM() {
    i2c_write_blocking_until(i2c1,DATA_BUS_SELECT,(uint8_t []){0x1},1,false,make_timeout_time_ms(50));
    i2c_write_blocking_until(i2c1,MEZZ_SELECT,(uint8_t []){0x01},1,false,make_timeout_time_ms(50)); // Select Mezzanine
    i2c_write_blocking_until(i2c1,SFP_SELECT,(uint8_t []){0x00},1,false,make_timeout_time_ms(50)); // Select SFP

    uint8_t buf[256];
    i2c_write_blocking(i2c1,0x51,(uint8_t []){0x00},1,true); 
    i2c_read_blocking(i2c1,0x51,buf,256,false);
    fflush(stdout);
    for (int i=0; i < 256; i++){
        printf("%02X",buf[i]);
    }
    printf("\n");
    fflush(stdout);
    
    return;
}


void inspect_SFP(uint8_t mezz, uint8_t link) {
    // Mezzanine and links are 0 indexed
    i2c_write_blocking_until(i2c1,DATA_BUS_SELECT,(uint8_t []){0x1},1,false,make_timeout_time_ms(50)); // select Data0/1
    i2c_write_blocking_until(i2c1,MEZZ_SELECT,(uint8_t []){1<<mezz},1,false,make_timeout_time_ms(50)); // Select Mezzanine
    i2c_write_blocking_until(i2c1,SFP_SELECT,(uint8_t []){1<<link},1,false,make_timeout_time_ms(50)); // Select SFP

    printf("mezz,%d,link,%d,",mezz,link);
    uint8_t buf[16];
    for (int i=0; i<16; i++){
        buf[i] = 0;
    }
    
    // Vendor Name
    for (int i=0; i<16; i++){
        i2c_write_blocking_until(i2c1,SFPA0H,(uint8_t []){i+20},1,true,make_timeout_time_ms(50));
        i2c_read_blocking_until(i2c1,SFPA0H,buf+i,1,false,make_timeout_time_ms(50));
    }
    printf("vendor,");
    for (int i=0; i<16; i++){
        printf("%c",buf[i]);
    }
    printf(",");

    // Part Number
    for (int i=0; i<16; i++){
        i2c_write_blocking_until(i2c1,SFPA0H,(uint8_t []){i+40},1,true,make_timeout_time_ms(50));
        i2c_read_blocking_until(i2c1,SFPA0H,buf+i,1,false,make_timeout_time_ms(50));
    }
    printf("part,");
    for (int i=0; i<16; i++){
        printf("%c",buf[i]);
    }
    printf(",");

    // Vendor Rev
    for (int i=0; i<4; i++){
        i2c_write_blocking_until(i2c1,SFPA0H,(uint8_t []){i+56},1,true,make_timeout_time_ms(50));
        i2c_read_blocking_until(i2c1,SFPA0H,buf+i,1,false,make_timeout_time_ms(50));
    }
    printf("rev,");
    for (int i=0; i<4; i++){
        printf("%c",buf[i]);
    }
    printf(",");
    // Vendor SN
    for (int i=0; i<16; i++){
        i2c_write_blocking_until(i2c1,SFPA0H,(uint8_t []){i+68},1,true,make_timeout_time_ms(50));
        i2c_read_blocking_until(i2c1,SFPA0H,buf+i,1,false,make_timeout_time_ms(50));
    }
    printf("SN,");
    for (int i=0; i<16; i++){
        printf("%c",buf[i]);
    }
    printf(",\n");

    return;
}
void pulse_LED(uint32_t ms) {
    gpio_put(LED_PIN,true);
    sleep_ms(ms);
    gpio_put(LED_PIN,false);
    sleep_ms(ms);
    return;
}

void flash_LED(uint32_t ms) {
    gpio_put(LED_PIN,true);
    sleep_ms(ms);
    gpio_put(LED_PIN,false);
    return;
}
    
    
