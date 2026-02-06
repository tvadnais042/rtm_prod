#include <stdio.h>
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
#define PLL_ADDR 0x68 // address of PLL on RTMV2

#define MAIN_SCREED "(R)e(B)oot, (S)hift_1s, (s)hift_20ms, (c)heck LED, (l)os check, (t)alk\n"

void config_pll();
bool scan_bus();
void check_los();
uint32_t step_fs(uint32_t us);

void main()
{
    set_sys_clock_khz(250000,true);

    stdio_init_all(); //init USB serial
    sleep_ms(3000); // slow to allow for screen connecting in time - debugging
    
    if (watchdog_caused_reboot()){
        printf("Watchdog Caused Reboot :(\n");
    }

    printf("Setup pins.......\n");

    // Init I2C pins
    i2c_init(i2c_default,100000);
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

    i2c_write_blocking_until(i2c_default,0x70,(uint8_t []){0x1},1,false, make_timeout_time_ms(50)); // opens 0x72 mezz mux
    i2c_write_blocking_until(i2c_default,0x72,(uint8_t []){0x8},1,false, make_timeout_time_ms(50)); // selects mezz4 (0x68)
    

    bool pllFlag = scan_bus();
    if (!pllFlag){
        printf("Cannot configure PLL at 0x68. Exiting\n");
        for (int i=0; i < 20; i++){
            gpio_put(LED_PIN,true);
            sleep_ms(30);
            gpio_put(LED_PIN,false);
            sleep_ms(30);
        }
    }
    else {
        gpio_put(LED_PIN, true); //held LED when successful
        config_pll();
        sleep_ms(1000);
        gpio_put(LED_PIN, false);
    }

    printf(MAIN_SCREED);
    while (true) {
        int c = stdio_getchar_timeout_us(0);
        if (c == 'B' || c == 'R') {
            printf("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH!!!!!!!!!!!!");
            printf("PLEASE DONT KILL ME I PROMISE I WILL PERFORM WHAT I NEED TO JUST DONT KILL ME PLEASE I CANT DIE NOT NOW NOT LIKE THIS!!!!");
            sleep_ms(100);
            reset_usb_boot(0,0); // enable BOOTSEL // BANG!
        }
        if (c == 's') {
            uint32_t dt = step_fs(20000);
            printf("STEP Function Time = %li.%.6li s\n", dt/1000000, dt%1000000);
            sleep_ms(5);
            printf(MAIN_SCREED);
        }
        if (c == 'S') {
            uint32_t dt = step_fs(1000000);
            printf("STEP Function Time = %li.%.6li s\n", dt/1000000, dt%1000000);
            sleep_ms(5);
            printf(MAIN_SCREED);
        }
        if (c == 't') {
            printf("Talk\n");
        }
        if (c == 'l') {
            check_los();
        }
        if (c == 'c') {
            // config_pll();
            gpio_put(LED_PIN,true);
            sleep_ms(30);
            gpio_put(LED_PIN,false);
            sleep_ms(30);
        }


        sleep_ms(5);
    }
    
    reset_usb_boot(0,0); // enable BOOTSEL // BANG!
}

bool scan_bus() {
    printf("Beginning I2C Scan\n");
    bool pllFlag = false;
    for (uint8_t addr; addr < 128; addr++) {
        uint8_t rxdata;
        int ret = i2c_read_blocking_until(i2c_default,addr, &rxdata, 1, false, make_timeout_time_ms(10)); //using i2c1 for pin 2,3
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
    // 160.03701 > no longer true. Bug in zynq clock. Ignoring.
    // password for the windows laptop in lab: intel123

    printf("Configuring PLLs\n");
    
    uint8_t page_now; // Wont know until first write

    // Preamble
    for (int i=0; i < 3; i++) {
        // printf("Reg %04X Val %02X \n",si5345_revd_registers[i].address, si5345_revd_registers[i].value);
    
        uint8_t page[2] = {0x01,si5344h_revd_registers[i].address >> 8};
        uint8_t data[2] = {si5344h_revd_registers[i].address & 0xff, si5344h_revd_registers[i].value}; 
        i2c_write_blocking(i2c_default,PLL_ADDR,page,2,false);
        page_now = page[1];
        i2c_write_blocking(i2c_default,PLL_ADDR,data,2,false);
    }

    sleep_ms(300);

    // Body + Postamble
    for (int i=3; i < SI5344H_REVD_REG_CONFIG_NUM_REGS; i++) {
        // printf("|%04X %02X",si5345_revd_registers[i].address, si5345_revd_registers[i].value);
        uint8_t page[2] = {0x01,si5344h_revd_registers[i].address >> 8};
        if (page_now != page[1]) {
            i2c_write_blocking(i2c_default,PLL_ADDR,page,2,false);
            page_now = page[1];
        }
        uint8_t data[2] = {si5344h_revd_registers[i].address & 0xff, si5344h_revd_registers[i].value}; 
        i2c_write_blocking(i2c_default,PLL_ADDR,data,2,false);

        // Check writes
        uint8_t readout;
        i2c_write_blocking(i2c_default,PLL_ADDR,&data[0],1,true);
        i2c_read_blocking(i2c_default,PLL_ADDR,&readout,1,false);
        if (readout != data[1] && i < SI5344H_REVD_REG_CONFIG_NUM_REGS-5) {
            printf("\nERROR! (%d) Reg %04X Val %02X != %02X\n",i, si5344h_revd_registers[i].address, data[1], readout);
        }
    }

    printf("End pll Config\n");
}

void check_los(){
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x01,0x00},2,false); // Write page
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x1C, 0x01},2,false);
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x12, 0x00},2,false);
    for (int i=0; i < 20; i++){
        uint8_t input_loc;
        uint8_t dspll_loc;
        uint8_t dspll_loc_sticky;
        i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x0D},1,true);
        i2c_read_blocking(i2c_default,PLL_ADDR,&input_loc,1,false);

        i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x0E},1,true);
        i2c_read_blocking(i2c_default,PLL_ADDR,&dspll_loc,1,false);

        i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x12},1,true);
        i2c_read_blocking(i2c_default,PLL_ADDR,&dspll_loc_sticky,1,false);
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
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x01,0x03},2,false); // write page
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x39,0b1011},2,false); // set mask

    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x47,0x64},2,false); // set the change high baby
    
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x01,0x00},2,false); // write page
    uint32_t t0 = time_us_32();
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x1D,0b01},2,false); // lets go shifting!!
    sleep_us(us);
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x1D,0b10},2,false); // lets go shifting!!
    uint32_t dt = time_us_32() - t0;

    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x01,0x03},2,false); // write page
    i2c_write_blocking(i2c_default,PLL_ADDR,(uint8_t[]){0x47,0x00},2,false); // get rid of that change baby
    
    return dt;
}
    
    
