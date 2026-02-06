/*
 * Si5344H Rev D Configuration Register Export Header File
 *
 * This file represents a series of Skyworks Si5344H Rev D 
 * register writes that can be performed to load a single configuration 
 * on a device. It was created by a Skyworks ClockBuilder Pro
 * export tool.
 *
 * Part:		                                       Si5344H Rev D
 * Design ID:                                          
 * Includes Pre/Post Download Control Register Writes: Yes
 * Created By:                                         ClockBuilder Pro v4.17 [2025-11-06]
 * Timestamp:                                          2026-02-05 11:19:51 GMT-08:00
 *
 * A complete design report corresponding to this export is included at the end 
 * of this header file.
 *
 */

#ifndef SI5344H_REVD_REG_CONFIG_HEADER
#define SI5344H_REVD_REG_CONFIG_HEADER

#define SI5344H_REVD_REG_CONFIG_NUM_REGS				410

typedef struct
{
	unsigned int address; /* 16-bit register address */
	unsigned char value; /* 8-bit register data */

} si5344h_revd_register_t;

si5344h_revd_register_t const si5344h_revd_registers[SI5344H_REVD_REG_CONFIG_NUM_REGS] =
{

	/* Start configuration preamble */
	{ 0x0B24, 0xC0 },
	{ 0x0B25, 0x00 },
	{ 0x0540, 0x01 },
	/* End configuration preamble */

	/* Delay 300 msec */
	/*    Delay is worst case time for device to complete any calibration */
	/*    that is running due to device state change previous to this script */
	/*    being processed. */

	/* Start configuration registers */
	{ 0x0006, 0x00 },
	{ 0x0007, 0x00 },
	{ 0x0008, 0x00 },
	{ 0x000B, 0x68 },
	{ 0x0016, 0x02 },
	{ 0x0017, 0xDC },
	{ 0x0018, 0xEE },
	{ 0x0019, 0xDD },
	{ 0x001A, 0xDF },
	{ 0x002B, 0x02 },
	{ 0x002C, 0x01 },
	{ 0x002D, 0x01 },
	{ 0x002E, 0x34 },
	{ 0x002F, 0x00 },
	{ 0x0030, 0x00 },
	{ 0x0031, 0x00 },
	{ 0x0036, 0x34 },
	{ 0x0037, 0x00 },
	{ 0x0038, 0x00 },
	{ 0x0039, 0x00 },
	{ 0x003F, 0x11 },
	{ 0x0040, 0x04 },
	{ 0x0041, 0x0E },
	{ 0x0042, 0x00 },
	{ 0x0045, 0x0C },
	{ 0x0046, 0x32 },
	{ 0x0047, 0x00 },
	{ 0x004A, 0x32 },
	{ 0x004B, 0x00 },
	{ 0x004E, 0x05 },
	{ 0x0050, 0x03 },
	{ 0x0051, 0x03 },
	{ 0x0052, 0x00 },
	{ 0x0055, 0x03 },
	{ 0x0056, 0x00 },
	{ 0x0059, 0x01 },
	{ 0x005A, 0x55 },
	{ 0x005B, 0x55 },
	{ 0x005C, 0xD5 },
	{ 0x005D, 0x00 },
	{ 0x005E, 0x00 },
	{ 0x005F, 0x00 },
	{ 0x0060, 0x00 },
	{ 0x0061, 0x00 },
	{ 0x0092, 0x02 },
	{ 0x0093, 0xA0 },
	{ 0x0095, 0x00 },
	{ 0x0096, 0x80 },
	{ 0x0098, 0x60 },
	{ 0x009A, 0x02 },
	{ 0x009B, 0x60 },
	{ 0x009D, 0x08 },
	{ 0x009E, 0x40 },
	{ 0x00A0, 0x20 },
	{ 0x00A2, 0x00 },
	{ 0x00A9, 0x33 },
	{ 0x00AA, 0x60 },
	{ 0x00AB, 0x00 },
	{ 0x00AC, 0x00 },
	{ 0x00E5, 0x00 },
	{ 0x00EA, 0x0A },
	{ 0x00EB, 0x60 },
	{ 0x00EC, 0x00 },
	{ 0x00ED, 0x00 },
	{ 0x0102, 0x01 },
	{ 0x0112, 0x02 },
	{ 0x0113, 0x09 },
	{ 0x0114, 0x3B },
	{ 0x0115, 0x28 },
	{ 0x0117, 0x06 },
	{ 0x0118, 0x09 },
	{ 0x0119, 0x3B },
	{ 0x011A, 0x29 },
	{ 0x0126, 0x02 },
	{ 0x0127, 0x09 },
	{ 0x0128, 0x3B },
	{ 0x0129, 0x2A },
	{ 0x012B, 0x06 },
	{ 0x012C, 0x09 },
	{ 0x012D, 0x3B },
	{ 0x012E, 0x29 },
	{ 0x013F, 0x00 },
	{ 0x0140, 0x00 },
	{ 0x0141, 0x40 },
	{ 0x0142, 0xFF },
	{ 0x0206, 0x00 },
	{ 0x0208, 0x50 },
	{ 0x0209, 0x00 },
	{ 0x020A, 0x00 },
	{ 0x020B, 0x00 },
	{ 0x020C, 0x00 },
	{ 0x020D, 0x00 },
	{ 0x020E, 0x01 },
	{ 0x020F, 0x00 },
	{ 0x0210, 0x00 },
	{ 0x0211, 0x00 },
	{ 0x0212, 0x00 },
	{ 0x0213, 0x00 },
	{ 0x0214, 0x00 },
	{ 0x0215, 0x00 },
	{ 0x0216, 0x00 },
	{ 0x0217, 0x00 },
	{ 0x0218, 0x00 },
	{ 0x0219, 0x00 },
	{ 0x021A, 0x00 },
	{ 0x021B, 0x00 },
	{ 0x0231, 0x0B },
	{ 0x0232, 0x0B },
	{ 0x0235, 0x00 },
	{ 0x0236, 0x10 },
	{ 0x0237, 0xA5 },
	{ 0x0238, 0xD4 },
	{ 0x0239, 0xE8 },
	{ 0x023A, 0x00 },
	{ 0x023B, 0xFC },
	{ 0x023C, 0x07 },
	{ 0x023D, 0x85 },
	{ 0x023E, 0xDF },
	{ 0x0250, 0x02 },
	{ 0x0251, 0x00 },
	{ 0x0252, 0x00 },
	{ 0x0253, 0x00 },
	{ 0x0254, 0x00 },
	{ 0x0255, 0x00 },
	{ 0x025C, 0x02 },
	{ 0x025D, 0x00 },
	{ 0x025E, 0x00 },
	{ 0x025F, 0x00 },
	{ 0x0260, 0x00 },
	{ 0x0261, 0x00 },
	{ 0x026B, 0x00 },
	{ 0x026C, 0x00 },
	{ 0x026D, 0x00 },
	{ 0x026E, 0x00 },
	{ 0x026F, 0x00 },
	{ 0x0270, 0x00 },
	{ 0x0271, 0x00 },
	{ 0x0272, 0x00 },
	{ 0x028A, 0x00 },
	{ 0x028B, 0x00 },
	{ 0x028E, 0x00 },
	{ 0x028F, 0x00 },
	{ 0x0294, 0x80 },
	{ 0x0296, 0x02 },
	{ 0x0297, 0x02 },
	{ 0x0299, 0x02 },
	{ 0x029D, 0xFA },
	{ 0x029E, 0x01 },
	{ 0x029F, 0x00 },
	{ 0x02A9, 0xCC },
	{ 0x02AA, 0x04 },
	{ 0x02AB, 0x00 },
	{ 0x02B7, 0xFF },
	{ 0x0302, 0x00 },
	{ 0x0303, 0x00 },
	{ 0x0304, 0x20 },
	{ 0x0305, 0xA1 },
	{ 0x0306, 0x07 },
	{ 0x0307, 0x00 },
	{ 0x0308, 0x00 },
	{ 0x0309, 0x60 },
	{ 0x030A, 0x7C },
	{ 0x030B, 0x92 },
	{ 0x030C, 0x00 },
	{ 0x030D, 0x00 },
	{ 0x030E, 0x00 },
	{ 0x030F, 0x00 },
	{ 0x0310, 0x00 },
	{ 0x0311, 0x14 },
	{ 0x0312, 0x00 },
	{ 0x0313, 0x00 },
	{ 0x0314, 0x00 },
	{ 0x0315, 0x00 },
	{ 0x0316, 0x80 },
	{ 0x0317, 0x00 },
	{ 0x0318, 0x00 },
	{ 0x0319, 0x00 },
	{ 0x031A, 0x20 },
	{ 0x031B, 0xA1 },
	{ 0x031C, 0x07 },
	{ 0x031D, 0x00 },
	{ 0x031E, 0x00 },
	{ 0x031F, 0x60 },
	{ 0x0320, 0x7C },
	{ 0x0321, 0x92 },
	{ 0x0322, 0x00 },
	{ 0x0323, 0x00 },
	{ 0x0324, 0x00 },
	{ 0x0325, 0x00 },
	{ 0x0326, 0x00 },
	{ 0x0327, 0x00 },
	{ 0x0328, 0x00 },
	{ 0x0329, 0x00 },
	{ 0x032A, 0x00 },
	{ 0x032B, 0x00 },
	{ 0x032C, 0x00 },
	{ 0x032D, 0x00 },
	{ 0x0338, 0x00 },
	{ 0x033B, 0x00 },
	{ 0x033C, 0x00 },
	{ 0x033D, 0x00 },
	{ 0x033E, 0x00 },
	{ 0x033F, 0x00 },
	{ 0x0340, 0x00 },
	{ 0x0341, 0x00 },
	{ 0x0342, 0x00 },
	{ 0x0343, 0x00 },
	{ 0x0344, 0x00 },
	{ 0x0345, 0x00 },
	{ 0x0346, 0x00 },
	{ 0x0347, 0x00 },
	{ 0x0348, 0x00 },
	{ 0x0349, 0x00 },
	{ 0x034A, 0x00 },
	{ 0x034B, 0x00 },
	{ 0x034C, 0x00 },
	{ 0x034D, 0x00 },
	{ 0x034E, 0x00 },
	{ 0x034F, 0x00 },
	{ 0x0350, 0x00 },
	{ 0x0351, 0x00 },
	{ 0x0352, 0x00 },
	{ 0x0359, 0x00 },
	{ 0x035A, 0x00 },
	{ 0x035B, 0x00 },
	{ 0x035C, 0x00 },
	{ 0x035D, 0x00 },
	{ 0x035E, 0x00 },
	{ 0x035F, 0x00 },
	{ 0x0360, 0x00 },
	{ 0x0487, 0x00 },
	{ 0x0508, 0x14 },
	{ 0x0509, 0x26 },
	{ 0x050A, 0x09 },
	{ 0x050B, 0x08 },
	{ 0x050C, 0x1F },
	{ 0x050D, 0x3F },
	{ 0x050E, 0x14 },
	{ 0x050F, 0x28 },
	{ 0x0510, 0x09 },
	{ 0x0511, 0x08 },
	{ 0x0512, 0x1F },
	{ 0x0513, 0x3F },
	{ 0x0515, 0x00 },
	{ 0x0516, 0x00 },
	{ 0x0517, 0x00 },
	{ 0x0518, 0x90 },
	{ 0x0519, 0xD0 },
	{ 0x051A, 0x03 },
	{ 0x051B, 0x00 },
	{ 0x051C, 0x00 },
	{ 0x051D, 0x80 },
	{ 0x051E, 0x50 },
	{ 0x051F, 0xC3 },
	{ 0x0521, 0x3B },
	{ 0x052A, 0x01 },
	{ 0x052B, 0x01 },
	{ 0x052C, 0x87 },
	{ 0x052D, 0x03 },
	{ 0x052E, 0x19 },
	{ 0x052F, 0x19 },
	{ 0x0531, 0x00 },
	{ 0x0532, 0x42 },
	{ 0x0533, 0x03 },
	{ 0x0534, 0x00 },
	{ 0x0535, 0x00 },
	{ 0x0536, 0x04 },
	{ 0x0537, 0x00 },
	{ 0x0538, 0x00 },
	{ 0x0539, 0x00 },
	{ 0x053A, 0x02 },
	{ 0x053B, 0x03 },
	{ 0x053C, 0x00 },
	{ 0x053D, 0x0E },
	{ 0x053E, 0x06 },
	{ 0x0589, 0x0D },
	{ 0x058A, 0x00 },
	{ 0x059B, 0xF8 },
	{ 0x059D, 0x14 },
	{ 0x059E, 0x28 },
	{ 0x059F, 0x09 },
	{ 0x05A0, 0x08 },
	{ 0x05A1, 0x1F },
	{ 0x05A2, 0x3F },
	{ 0x05A6, 0x03 },
	{ 0x0802, 0x35 },
	{ 0x0803, 0x05 },
	{ 0x0804, 0x00 },
	{ 0x0805, 0x40 },
	{ 0x0806, 0x05 },
	{ 0x0807, 0x01 },
	{ 0x0808, 0x00 },
	{ 0x0809, 0x00 },
	{ 0x080A, 0x00 },
	{ 0x080B, 0x00 },
	{ 0x080C, 0x00 },
	{ 0x080D, 0x00 },
	{ 0x080E, 0x00 },
	{ 0x080F, 0x00 },
	{ 0x0810, 0x00 },
	{ 0x0811, 0x00 },
	{ 0x0812, 0x00 },
	{ 0x0813, 0x00 },
	{ 0x0814, 0x00 },
	{ 0x0815, 0x00 },
	{ 0x0816, 0x00 },
	{ 0x0817, 0x00 },
	{ 0x0818, 0x00 },
	{ 0x0819, 0x00 },
	{ 0x081A, 0x00 },
	{ 0x081B, 0x00 },
	{ 0x081C, 0x00 },
	{ 0x081D, 0x00 },
	{ 0x081E, 0x00 },
	{ 0x081F, 0x00 },
	{ 0x0820, 0x00 },
	{ 0x0821, 0x00 },
	{ 0x0822, 0x00 },
	{ 0x0823, 0x00 },
	{ 0x0824, 0x00 },
	{ 0x0825, 0x00 },
	{ 0x0826, 0x00 },
	{ 0x0827, 0x00 },
	{ 0x0828, 0x00 },
	{ 0x0829, 0x00 },
	{ 0x082A, 0x00 },
	{ 0x082B, 0x00 },
	{ 0x082C, 0x00 },
	{ 0x082D, 0x00 },
	{ 0x082E, 0x00 },
	{ 0x082F, 0x00 },
	{ 0x0830, 0x00 },
	{ 0x0831, 0x00 },
	{ 0x0832, 0x00 },
	{ 0x0833, 0x00 },
	{ 0x0834, 0x00 },
	{ 0x0835, 0x00 },
	{ 0x0836, 0x00 },
	{ 0x0837, 0x00 },
	{ 0x0838, 0x00 },
	{ 0x0839, 0x00 },
	{ 0x083A, 0x00 },
	{ 0x083B, 0x00 },
	{ 0x083C, 0x00 },
	{ 0x083D, 0x00 },
	{ 0x083E, 0x00 },
	{ 0x083F, 0x00 },
	{ 0x0840, 0x00 },
	{ 0x0841, 0x00 },
	{ 0x0842, 0x00 },
	{ 0x0843, 0x00 },
	{ 0x0844, 0x00 },
	{ 0x0845, 0x00 },
	{ 0x0846, 0x00 },
	{ 0x0847, 0x00 },
	{ 0x0848, 0x00 },
	{ 0x0849, 0x00 },
	{ 0x084A, 0x00 },
	{ 0x084B, 0x00 },
	{ 0x084C, 0x00 },
	{ 0x084D, 0x00 },
	{ 0x084E, 0x00 },
	{ 0x084F, 0x00 },
	{ 0x0850, 0x00 },
	{ 0x0851, 0x00 },
	{ 0x0852, 0x00 },
	{ 0x0853, 0x00 },
	{ 0x0854, 0x00 },
	{ 0x0855, 0x00 },
	{ 0x0856, 0x00 },
	{ 0x0857, 0x00 },
	{ 0x0858, 0x00 },
	{ 0x0859, 0x00 },
	{ 0x085A, 0x00 },
	{ 0x085B, 0x00 },
	{ 0x085C, 0x00 },
	{ 0x085D, 0x00 },
	{ 0x085E, 0x00 },
	{ 0x085F, 0x00 },
	{ 0x0860, 0x00 },
	{ 0x0861, 0x00 },
	{ 0x090E, 0x02 },
	{ 0x0943, 0x00 },
	{ 0x0949, 0x01 },
	{ 0x094A, 0x01 },
	{ 0x094E, 0x49 },
	{ 0x094F, 0x02 },
	{ 0x095E, 0x00 },
	{ 0x0A02, 0x00 },
	{ 0x0A03, 0x07 },
	{ 0x0A04, 0x02 },
	{ 0x0A05, 0x07 },
	{ 0x0A14, 0x00 },
	{ 0x0A1A, 0x00 },
	{ 0x0A20, 0x00 },
	{ 0x0A26, 0x00 },
	{ 0x0B44, 0x03 },
	{ 0x0B46, 0x00 },
	{ 0x0B47, 0x02 },
	{ 0x0B48, 0x02 },
	{ 0x0B4A, 0x08 },
	{ 0x0B57, 0x04 },
	{ 0x0B58, 0x01 },
	/* End configuration registers */

	/* Start configuration postamble */
	{ 0x0514, 0x01 },
	{ 0x001C, 0x01 },
	{ 0x0B24, 0xC3 },
	{ 0x0B25, 0x02 },
	/* End configuration postamble */

};

/*
 * Design Report
 *
 * Overview
 * ========
 * 
 * Part:               Si5344H Rev D
 * Design ID:          <none>
 * Created By:         ClockBuilder Pro v4.17 [2025-11-06]
 * Timestamp:          2026-02-05 11:19:51 GMT-08:00
 * 
 * Design Rule Check
 * =================
 * 
 * Errors:
 * - No errors
 * 
 * Warnings:
 * - DSPLL: the actual bandwidth (775.19 Hz) is significantly less than the
 *   desired bandwidth (4.00 kHz) due to CBPro optimizing for lowest jitter down
 *   to 1 kHz. If this is unacceptable for your application, please contact
 *   Skyworks.
 * - OUT0 [160 MHz] and OUT1 [159.998400... MHz] may have coupling [1]
 * - OUT1 [159.998400... MHz] and OUT2 [160 MHz] may have coupling [1]
 * - OUT2 [160 MHz] and OUT3 [159.998400... MHz] may have coupling [1]
 * 
 * Footnotes:
 * [1] To avoid coupling between outputs, Skyworks recommends the following:
 * 
 * - Avoid adjacent frequency values that are close to each other.
 * - Adjacent frequency values that are integer multiples of one another are okay
 *   and these outputs should be grouped accordingly. For example, a 155.52 MHz
 *   and 622.08 MHz (155.52 x 4) can be adjacent.
 * - Unused outputs can be used to separate clock outputs that might otherwise
 *   interfere with one another.
 * - CBPro uses an clock's integration bandwidth (IBW) to determine whether two
 *   adjacent frequencies are too close. An IBW of 20 MHz is used for frequencies
 *   80 MHz and larger. Lower frequencies will use IBW of OUT/4. CBPro will flag
 *   fundamental coupling and coupling up to the fourth harmonic, where coupling
 *   frequency = Absolute(OUTa*x - OUTb*y) for all combinations of x and y 1
 *   through 4. If any one of these values is less than or equal to the IBW, the
 *   clock is flagged as having possible coupling.
 * 
 * Skyworks recommends you validate your design's jitter performance using an Evaluation Board. You can request a custom phase noise report for your design from CBPro's design dashboard.
 * 
 * Design
 * ======
 * Host Interface:
 *    I/O Power Supply: VDD (Core)
 *    SPI Mode: 4-Wire
 *    I2C Address Range: 104d to 107d / 0x68 to 0x6B (selected via A0/A1 pins)
 * 
 * XA/XB:
 *    48 MHz (XTAL - Crystal)
 * 
 * Inputs:
 *     IN0: 160 MHz
 *          Standard
 *     IN1: Unused
 * 
 * Outputs:
 *    OUT0: 160 MHz
 *          Enabled, LVDS 2.5 V
 *    OUT1: 159.9984000159998400... MHz [ 159 + 99841/100001 MHz ]
 *          [ out0 * (100000/100001) ]
 *          Enabled, LVDS 2.5 V
 *    OUT2: 160 MHz
 *          Enabled, LVDS 2.5 V
 *    OUT3: 159.9984000159998400... MHz [ 159 + 99841/100001 MHz ]
 *          Enabled, LVDS 2.5 V
 * 
 * Frequency Plan
 * ==============
 * 
 * Priority: maximize the number of low jitter outputs
 * 
 * Fvco = 12.7998720012799872... GHz [ 12 + 79988/100001 GHz ]
 * Fpfd = 2 MHz
 * Fms0 = 960 MHz
 * Fms1 = 319.9968000319996800... MHz [ 319 + 99681/100001 MHz ]
 * Fms2 = 960 MHz
 * 
 * P dividers:
 *    P0  = 80
 *    P1  = Unused
 *    Pxaxb = 1
 * 
 * MXAXB = 266.6640000266664000... [ 266 + 199202/300003 ]
 * M = 1279.9872001279987200... [ 1279 + 98721/100001 ]
 * N dividers:
 *    N0:
 *       Value: 13.3332000013333200... [ 13 + 99961/300003 ]
 *       OUT0: 160 MHz
 *    N1:
 *       Value: 40
 *       OUT1: 159.9984000159998400... MHz [ 159 + 99841/100001 MHz ]
 *       OUT3: 159.9984000159998400... MHz [ 159 + 99841/100001 MHz ]
 *    N2:
 *       Value: 13.3332000013333200... [ 13 + 99961/300003 ]
 *       OUT2: 160 MHz
 *    N3:
 *       Unused
 * 
 * R dividers:
 *    R0 = 6
 *    R1 = 2
 *    R2 = 6
 *    R3 = 2
 * 
 * Nominal Bandwidth:
 *   Desired: 4.000 kHz
 *   Actual:  775.186 Hz
 *   Coefficients:
 *      BW0:  20
 *      BW1:  38
 *      BW2:  9
 *      BW3:  8
 *      BW4:  31
 *      BW5:  63
 * Fastlock Bandwidth:
 *   Desired: 4.000 kHz
 *   Actual:  775.186 Hz
 *   Coefficients:
 *      BW0:  20
 *      BW1:  40
 *      BW2:  9
 *      BW3:  8
 *      BW4:  31
 *      BW5:  63
 * Holdover Bandwidth:
 *    N/A (Ramped Exit from Holdover)
 * 
 * Dividers listed above show effective values. These values are translated to register settings by ClockBuilder Pro. For the actual register values, see below. Refer to the Family Reference Manual for information on registers related to frequency plan.
 * 
 * Digitally Controlled Oscillator (DCO)
 * =====================================
 * DCO Enabled
 * 
 *        Fxaxb * PXAXB * MXAXB_NUM * Nx_DEN 
 * Fout = -----------------------------------
 *              MXAXB_DEN * Nx_NUM * Rz      
 * 
 * Fxaxb:              48 MHz
 * MXAXB_NUM:          1000000000000
 * MXAXB_DEN:          3750037500
 * PXAXB:              1
 * 
 * Desired Step Size:  1 ppt
 * Actual Step Size:   1 ppt
 * Range:              1 ppt
 * 
 * OUT0
 *      N0_NUM:        32768000000
 *      N0_DEN:        2457624576
 *      R0:            6
 *      Initial Freq:  160 MHz
 *      Step Size:     0.00016 Hz
 *      Min Freq:      159.99999999984 MHz
 *      Max Freq:      160.00000000016 MHz
 * 
 * OUT1
 *      N1_NUM:        85899345920
 *      N1_DEN:        2147483648
 *      R1:            2
 *      Initial Freq:  159.998400015999... MHz
 *      Step Size:     0.000159998400... Hz
 *      Min Freq:      159.998400015839... MHz
 *      Max Freq:      159.998400016159... MHz
 * 
 * OUT2
 *      N2_NUM:        32768000000
 *      N2_DEN:        2457624576
 *      R2:            6
 *      Initial Freq:  160 MHz
 *      Step Size:     0.00016 Hz
 *      Min Freq:      159.99999999984 MHz
 *      Max Freq:      160.00000000016 MHz
 * 
 * OUT3
 *      N1_NUM:        85899345920
 *      N1_DEN:        2147483648
 *      R3:            2
 *      Initial Freq:  159.998400015999... MHz
 *      Step Size:     0.000159998400... Hz
 *      Min Freq:      159.998400015839... MHz
 *      Max Freq:      159.998400016159... MHz
 * 
 * Estimated Power & Junction Temperature
 * ======================================
 * Assumptions:
 * 
 * VDD:      1.8 V
 * Ta:       25 °C
 * Theta-JA: 18.30 °C/W (JEDEC Board with 2 m/s airflow)
 * 
 *                               Overall  On Chip
 * Condition                     Power    Power    Ta    Tj
 * ----------------------------  -------  -------  ----  ----
 * Typical Ta, Voltage, Current  870 mW   846 mW   25 C  40 C
 * 
 *                                           -----------------------
 *                                                   Typical        
 *                                           -----------------------
 *                                           Voltage  Current  Power
 *        Output  Frequency          Format    (V)     (mA)    (mW) 
 *        ------  -----------------  ------  -------  -------  -----
 * VDD                                          1.80      180    323
 * VDDA                                         3.30      118    389
 * VDDO0  OUT0              160 MHz    LVDS     2.50       16     39
 * VDDO1  OUT1    159.998400... MHz    LVDS     2.50       16     39
 * VDDO2  OUT2              160 MHz    LVDS     2.50       16     39
 * VDDO3  OUT3    159.998400... MHz    LVDS     2.50       16     39
 *                                           -------  -------  -----
 *                                              1.80      180    323
 *                                              2.50       63    157
 *                                              3.30      118    389
 *                                           -------  -------  -----
 *                                             Total             870
 *                                           -------  -------  -----
 * 
 * Note:
 * 
 * - Tj is junction temperature. Tj must be less than 125 °C (on Si5344H Revision
 *   D) for device to comply with datasheet specifications. Tj = Ta +
 *   Theta_JA*On_Chip_Power.
 * - Overall power includes on-chip power dissipation and adds differential load
 *   power dissipation to estimate total power requirements.
 * - Above are estimates only: power and temperature should be measured on your
 *   PCB.
 * - Selection of appropriate Theta-JA is required for most accurate estimate.
 *   Ideally, select 'User Specified Theta-JA' and enter a Theta-JA value based
 *   on the thermal properties of your PCB.
 * 
 * Settings
 * ========
 * 
 * Location      Setting Name                Decimal Value      Hex Value        
 * ------------  --------------------------  -----------------  -----------------
 * 0x0006[23:0]  TOOL_VERSION                0                  0x000000         
 * 0x000B[6:0]   I2C_ADDR                    104                0x68             
 * 0x0016[1]     LOL_ON_HOLD                 1                  0x1              
 * 0x0017[0]     SYSINCAL_INTR_MSK           0                  0x0              
 * 0x0017[1]     LOSXAXB_INTR_MSK            0                  0x0              
 * 0x0017[5]     SMB_TMOUT_INTR_MSK          0                  0x0              
 * 0x0018[3:0]   LOS_INTR_MSK                14                 0x0E             
 * 0x0018[7:4]   OOF_INTR_MSK                14                 0x0E             
 * 0x0019[1]     LOL_INTR_MSK                0                  0x0              
 * 0x0019[5]     HOLD_INTR_MSK               0                  0x0              
 * 0x001A[5]     CAL_INTR_MSK                0                  0x0              
 * 0x002B[3]     SPI_3WIRE                   0                  0x0              
 * 0x002B[5]     AUTO_NDIV_UPDATE            0                  0x0              
 * 0x002C[3:0]   LOS_EN                      1                  0x1              
 * 0x002C[4]     LOSXAXB_DIS                 0                  0x0              
 * 0x002D[1:0]   LOS0_VAL_TIME               1                  0x1              
 * 0x002D[3:2]   LOS1_VAL_TIME               0                  0x0              
 * 0x002E[15:0]  LOS0_TRG_THR                52                 0x0034           
 * 0x0030[15:0]  LOS1_TRG_THR                0                  0x0000           
 * 0x0036[15:0]  LOS0_CLR_THR                52                 0x0034           
 * 0x0038[15:0]  LOS1_CLR_THR                0                  0x0000           
 * 0x003F[3:0]   OOF_EN                      1                  0x1              
 * 0x003F[7:4]   FAST_OOF_EN                 1                  0x1              
 * 0x0040[2:0]   OOF_REF_SEL                 4                  0x4              
 * 0x0041[4:0]   OOF0_DIV_SEL                14                 0x0E             
 * 0x0042[4:0]   OOF1_DIV_SEL                0                  0x00             
 * 0x0045[4:0]   OOFXO_DIV_SEL               12                 0x0C             
 * 0x0046[7:0]   OOF0_SET_THR                50                 0x32             
 * 0x0047[7:0]   OOF1_SET_THR                0                  0x00             
 * 0x004A[7:0]   OOF0_CLR_THR                50                 0x32             
 * 0x004B[7:0]   OOF1_CLR_THR                0                  0x00             
 * 0x004E[2:0]   OOF0_DETWIN_SEL             5                  0x5              
 * 0x004E[6:4]   OOF1_DETWIN_SEL             0                  0x0              
 * 0x0050[3:0]   OOF_ON_LOS                  3                  0x3              
 * 0x0051[3:0]   FAST_OOF0_SET_THR           3                  0x3              
 * 0x0052[3:0]   FAST_OOF1_SET_THR           0                  0x0              
 * 0x0055[3:0]   FAST_OOF0_CLR_THR           3                  0x3              
 * 0x0056[3:0]   FAST_OOF1_CLR_THR           0                  0x0              
 * 0x0059[1:0]   FAST_OOF0_DETWIN_SEL        1                  0x1              
 * 0x0059[3:2]   FAST_OOF1_DETWIN_SEL        0                  0x0              
 * 0x005A[25:0]  OOF0_RATIO_REF              13981013           0x0D55555        
 * 0x005E[25:0]  OOF1_RATIO_REF              0                  0x0000000        
 * 0x0092[1]     LOL_FST_EN                  1                  0x1              
 * 0x0093[7:4]   LOL_FST_DETWIN_SEL          10                 0x0A             
 * 0x0095[3:2]   LOL_FST_VALWIN_SEL          0                  0x0              
 * 0x0096[7:4]   LOL_FST_SET_THR_SEL         8                  0x08             
 * 0x0098[7:4]   LOL_FST_CLR_THR_SEL         6                  0x6              
 * 0x009A[1]     LOL_SLOW_EN_PLL             1                  0x1              
 * 0x009B[7:4]   LOL_SLW_DETWIN_SEL          6                  0x6              
 * 0x009D[3:2]   LOL_SLW_VALWIN_SEL          2                  0x2              
 * 0x009E[7:4]   LOL_SLW_SET_THR             4                  0x4              
 * 0x00A0[7:4]   LOL_SLW_CLR_THR             2                  0x2              
 * 0x00A2[1]     LOL_TIMER_EN                0                  0x0              
 * 0x00A9[28:0]  LOL_CLR_DELAY_DIV256        24627              0x00006033       
 * 0x00E5[0]     FASTLOCK_EXTEND_MASTER_DIS  0                  0x0              
 * 0x00E5[5]     FASTLOCK_EXTEND_EN          0                  0x0              
 * 0x00EA[28:0]  FASTLOCK_EXTEND             24586              0x0000600A       
 * 0x0102[0]     OUTALL_DISABLE_LOW          1                  0x1              
 * 0x0112[0]     OUT0_PDN                    0                  0x0              
 * 0x0112[1]     OUT0_OE                     1                  0x1              
 * 0x0112[2]     OUT0_RDIV_FORCE2            0                  0x0              
 * 0x0112[3]     OUT0_DIV2_BYP               0                  0x0              
 * 0x0113[2:0]   OUT0_FORMAT                 1                  0x1              
 * 0x0113[3]     OUT0_SYNC_EN                1                  0x1              
 * 0x0113[5:4]   OUT0_DIS_STATE              0                  0x0              
 * 0x0113[7:6]   OUT0_CMOS_DRV               0                  0x0              
 * 0x0114[3:0]   OUT0_CM                     11                 0x0B             
 * 0x0114[6:4]   OUT0_AMPL                   3                  0x3              
 * 0x0115[2:0]   OUT0_MUX_SEL                0                  0x0              
 * 0x0115[5:4]   OUT0_VDD_SEL                2                  0x2              
 * 0x0115[3]     OUT0_VDD_SEL_EN             1                  0x1              
 * 0x0115[7:6]   OUT0_INV                    0                  0x0              
 * 0x0117[0]     OUT1_PDN                    0                  0x0              
 * 0x0117[1]     OUT1_OE                     1                  0x1              
 * 0x0117[2]     OUT1_RDIV_FORCE2            1                  0x1              
 * 0x0117[3]     OUT1_DIV2_BYP               0                  0x0              
 * 0x0118[2:0]   OUT1_FORMAT                 1                  0x1              
 * 0x0118[3]     OUT1_SYNC_EN                1                  0x1              
 * 0x0118[5:4]   OUT1_DIS_STATE              0                  0x0              
 * 0x0118[7:6]   OUT1_CMOS_DRV               0                  0x0              
 * 0x0119[3:0]   OUT1_CM                     11                 0x0B             
 * 0x0119[6:4]   OUT1_AMPL                   3                  0x3              
 * 0x011A[2:0]   OUT1_MUX_SEL                1                  0x1              
 * 0x011A[5:4]   OUT1_VDD_SEL                2                  0x2              
 * 0x011A[3]     OUT1_VDD_SEL_EN             1                  0x1              
 * 0x011A[7:6]   OUT1_INV                    0                  0x0              
 * 0x0126[0]     OUT2_PDN                    0                  0x0              
 * 0x0126[1]     OUT2_OE                     1                  0x1              
 * 0x0126[2]     OUT2_RDIV_FORCE2            0                  0x0              
 * 0x0126[3]     OUT2_DIV2_BYP               0                  0x0              
 * 0x0127[2:0]   OUT2_FORMAT                 1                  0x1              
 * 0x0127[3]     OUT2_SYNC_EN                1                  0x1              
 * 0x0127[5:4]   OUT2_DIS_STATE              0                  0x0              
 * 0x0127[7:6]   OUT2_CMOS_DRV               0                  0x0              
 * 0x0128[3:0]   OUT2_CM                     11                 0x0B             
 * 0x0128[6:4]   OUT2_AMPL                   3                  0x3              
 * 0x0129[2:0]   OUT2_MUX_SEL                2                  0x2              
 * 0x0129[5:4]   OUT2_VDD_SEL                2                  0x2              
 * 0x0129[3]     OUT2_VDD_SEL_EN             1                  0x1              
 * 0x0129[7:6]   OUT2_INV                    0                  0x0              
 * 0x012B[0]     OUT3_PDN                    0                  0x0              
 * 0x012B[1]     OUT3_OE                     1                  0x1              
 * 0x012B[2]     OUT3_RDIV_FORCE2            1                  0x1              
 * 0x012B[3]     OUT3_DIV2_BYP               0                  0x0              
 * 0x012C[2:0]   OUT3_FORMAT                 1                  0x1              
 * 0x012C[3]     OUT3_SYNC_EN                1                  0x1              
 * 0x012C[5:4]   OUT3_DIS_STATE              0                  0x0              
 * 0x012C[7:6]   OUT3_CMOS_DRV               0                  0x0              
 * 0x012D[3:0]   OUT3_CM                     11                 0x0B             
 * 0x012D[6:4]   OUT3_AMPL                   3                  0x3              
 * 0x012E[2:0]   OUT3_MUX_SEL                1                  0x1              
 * 0x012E[5:4]   OUT3_VDD_SEL                2                  0x2              
 * 0x012E[3]     OUT3_VDD_SEL_EN             1                  0x1              
 * 0x012E[7:6]   OUT3_INV                    0                  0x0              
 * 0x013F[11:0]  OUTX_ALWAYS_ON              0                  0x000            
 * 0x0141[1]     OUT_DIS_MSK                 0                  0x0              
 * 0x0141[5]     OUT_DIS_LOL_MSK             0                  0x0              
 * 0x0141[6]     OUT_DIS_LOSXAXB_MSK         1                  0x1              
 * 0x0141[7]     OUT_DIS_MSK_LOS_PFD         0                  0x0              
 * 0x0142[1]     OUT_DIS_MSK_LOL             1                  0x1              
 * 0x0142[5]     OUT_DIS_MSK_HOLD            1                  0x1              
 * 0x0206[1:0]   PXAXB                       0                  0x0              
 * 0x0208[47:0]  P0_NUM                      80                 0x000000000050   
 * 0x020E[31:0]  P0_DEN                      1                  0x00000001       
 * 0x0212[47:0]  P1_NUM                      0                  0x000000000000   
 * 0x0218[31:0]  P1_DEN                      0                  0x00000000       
 * 0x0231[3:0]   P0_FRACN_MODE               11                 0x0B             
 * 0x0231[4]     P0_FRACN_EN                 0                  0x0              
 * 0x0232[3:0]   P1_FRACN_MODE               11                 0x0B             
 * 0x0232[4]     P1_FRACN_EN                 0                  0x0              
 * 0x0235[43:0]  MXAXB_NUM                   1000000000000      0x0E8D4A51000    
 * 0x023B[31:0]  MXAXB_DEN                   3750037500         0x0DF8507FC      
 * 0x0250[23:0]  R0_REG                      2                  0x000002         
 * 0x0253[23:0]  R1_REG                      0                  0x000000         
 * 0x025C[23:0]  R2_REG                      2                  0x000002         
 * 0x025F[23:0]  R3_REG                      0                  0x000000         
 * 0x026B[7:0]   DESIGN_ID0                  0                  0x00             
 * 0x026C[7:0]   DESIGN_ID1                  0                  0x00             
 * 0x026D[7:0]   DESIGN_ID2                  0                  0x00             
 * 0x026E[7:0]   DESIGN_ID3                  0                  0x00             
 * 0x026F[7:0]   DESIGN_ID4                  0                  0x00             
 * 0x0270[7:0]   DESIGN_ID5                  0                  0x00             
 * 0x0271[7:0]   DESIGN_ID6                  0                  0x00             
 * 0x0272[7:0]   DESIGN_ID7                  0                  0x00             
 * 0x028A[4:0]   OOF0_TRG_THR_EXT            0                  0x00             
 * 0x028B[4:0]   OOF1_TRG_THR_EXT            0                  0x00             
 * 0x028E[4:0]   OOF0_CLR_THR_EXT            0                  0x00             
 * 0x028F[4:0]   OOF1_CLR_THR_EXT            0                  0x00             
 * 0x0294[7:4]   FASTLOCK_EXTEND_SCL         8                  0x08             
 * 0x0296[1]     LOL_SLW_VALWIN_SELX         1                  0x1              
 * 0x0297[1]     FASTLOCK_DLY_ONSW_EN        1                  0x1              
 * 0x0299[1]     FASTLOCK_DLY_ONLOL_EN       1                  0x1              
 * 0x029D[19:0]  FASTLOCK_DLY_ONLOL          506                0x001FA          
 * 0x02A9[19:0]  FASTLOCK_DLY_ONSW           1228               0x004CC          
 * 0x02B7[3:2]   LOL_NOSIG_TIME              3                  0x3              
 * 0x0302[43:0]  N0_NUM                      32768000000        0x007A1200000    
 * 0x0308[31:0]  N0_DEN                      2457624576         0x0927C6000      
 * 0x030C[0]     N0_UPDATE                   0                  0x0              
 * 0x030D[43:0]  N1_NUM                      85899345920        0x01400000000    
 * 0x0313[31:0]  N1_DEN                      2147483648         0x080000000      
 * 0x0317[0]     N1_UPDATE                   0                  0x0              
 * 0x0318[43:0]  N2_NUM                      32768000000        0x007A1200000    
 * 0x031E[31:0]  N2_DEN                      2457624576         0x0927C6000      
 * 0x0322[0]     N2_UPDATE                   0                  0x0              
 * 0x0323[43:0]  N3_NUM                      0                  0x00000000000    
 * 0x0329[31:0]  N3_DEN                      0                  0x00000000       
 * 0x032D[0]     N3_UPDATE                   0                  0x0              
 * 0x0338[1]     N_UPDATE                    0                  0x0              
 * 0x033B[43:0]  N0_FSTEPW                   0                  0x00000000000    
 * 0x0341[43:0]  N1_FSTEPW                   0                  0x00000000000    
 * 0x0347[43:0]  N2_FSTEPW                   0                  0x00000000000    
 * 0x034D[43:0]  N3_FSTEPW                   0                  0x00000000000    
 * 0x0359[15:0]  N0_DELAY                    0                  0x0000           
 * 0x035B[15:0]  N1_DELAY                    0                  0x0000           
 * 0x035D[15:0]  N2_DELAY                    0                  0x0000           
 * 0x035F[15:0]  N3_DELAY                    0                  0x0000           
 * 0x0487[4]     ZDM_AUTOSW_EN               0                  0x0              
 * 0x0508[5:0]   BW0_PLL                     20                 0x14             
 * 0x0509[5:0]   BW1_PLL                     38                 0x26             
 * 0x050A[5:0]   BW2_PLL                     9                  0x09             
 * 0x050B[5:0]   BW3_PLL                     8                  0x08             
 * 0x050C[5:0]   BW4_PLL                     31                 0x1F             
 * 0x050D[5:0]   BW5_PLL                     63                 0x3F             
 * 0x050E[5:0]   FASTLOCK_BW0_PLL            20                 0x14             
 * 0x050F[5:0]   FASTLOCK_BW1_PLL            40                 0x28             
 * 0x0510[5:0]   FASTLOCK_BW2_PLL            9                  0x09             
 * 0x0511[5:0]   FASTLOCK_BW3_PLL            8                  0x08             
 * 0x0512[5:0]   FASTLOCK_BW4_PLL            31                 0x1F             
 * 0x0513[5:0]   FASTLOCK_BW5_PLL            63                 0x3F             
 * 0x0515[55:0]  M_NUM                       4194304000000      0x0003D090000000 
 * 0x051C[31:0]  M_DEN                       3276832768         0x0C3508000      
 * 0x0521[3:0]   M_FRAC_MODE                 11                 0x0B             
 * 0x0521[4]     M_FRAC_EN                   1                  0x1              
 * 0x0521[5]     PLL_OUT_RATE_SEL            1                  0x1              
 * 0x052A[0]     IN_SEL_REGCTRL              1                  0x1              
 * 0x052A[3:1]   IN_SEL                      0                  0x0              
 * 0x052B[0]     FASTLOCK_AUTO_EN            1                  0x1              
 * 0x052B[1]     FASTLOCK_MAN                0                  0x0              
 * 0x052C[0]     HOLD_EN                     1                  0x1              
 * 0x052C[3]     HOLD_RAMP_BYP               0                  0x0              
 * 0x052C[4]     HOLDEXIT_BW_SEL1            0                  0x0              
 * 0x052C[7:5]   RAMP_STEP_INTERVAL          4                  0x4              
 * 0x052D[1]     HOLD_RAMPBYP_NOHIST         1                  0x1              
 * 0x052E[4:0]   HOLD_HIST_LEN               25                 0x19             
 * 0x052F[4:0]   HOLD_HIST_DELAY             25                 0x19             
 * 0x0531[4:0]   HOLD_REF_COUNT_FRC          0                  0x00             
 * 0x0532[23:0]  HOLD_15M_CYC_COUNT          834                0x000342         
 * 0x0535[0]     FORCE_HOLD                  0                  0x0              
 * 0x0536[1:0]   CLK_SWITCH_MODE             0                  0x0              
 * 0x0536[2]     HSW_EN                      1                  0x1              
 * 0x0537[3:0]   IN_LOS_MSK                  0                  0x0              
 * 0x0537[7:4]   IN_OOF_MSK                  0                  0x0              
 * 0x0538[2:0]   IN0_PRIORITY                0                  0x0              
 * 0x0538[6:4]   IN1_PRIORITY                0                  0x0              
 * 0x0539[2:0]   IN2_PRIORITY                0                  0x0              
 * 0x0539[6:4]   IN3_PRIORITY                0                  0x0              
 * 0x053A[1:0]   HSW_MODE                    2                  0x2              
 * 0x053A[3:2]   HSW_PHMEAS_CTRL             0                  0x0              
 * 0x053B[9:0]   HSW_PHMEAS_THR              3                  0x003            
 * 0x053D[4:0]   HSW_COARSE_PM_LEN           14                 0x0E             
 * 0x053E[4:0]   HSW_COARSE_PM_DLY           6                  0x06             
 * 0x0540[0]     OUTERLOOP_DIS               1                  0x1              
 * 0x0589[12:0]  PFD_EN_DELAY                13                 0x000D           
 * 0x059B[1]     INIT_LP_CLOSE_HO            0                  0x0              
 * 0x059B[4]     HOLD_PRESERVE_HIST          1                  0x1              
 * 0x059B[5]     HOLD_FRZ_WITH_INTONLY       1                  0x1              
 * 0x059B[6]     HOLDEXIT_BW_SEL0            1                  0x1              
 * 0x059B[7]     HOLDEXIT_STD_BO             1                  0x1              
 * 0x059D[5:0]   HOLDEXIT_BW0                20                 0x14             
 * 0x059E[5:0]   HOLDEXIT_BW1                40                 0x28             
 * 0x059F[5:0]   HOLDEXIT_BW2                9                  0x09             
 * 0x05A0[5:0]   HOLDEXIT_BW3                8                  0x08             
 * 0x05A1[5:0]   HOLDEXIT_BW4                31                 0x1F             
 * 0x05A2[5:0]   HOLDEXIT_BW5                63                 0x3F             
 * 0x05A6[2:0]   RAMP_STEP_SIZE              3                  0x3              
 * 0x05A6[3]     RAMP_SWITCH_EN              0                  0x0              
 * 0x0802[15:0]  FIXREGSA0                   1333               0x0535           
 * 0x0804[7:0]   FIXREGSD0                   0                  0x00             
 * 0x0805[15:0]  FIXREGSA1                   1344               0x0540           
 * 0x0807[7:0]   FIXREGSD1                   1                  0x01             
 * 0x0808[15:0]  FIXREGSA2                   0                  0x0000           
 * 0x080A[7:0]   FIXREGSD2                   0                  0x00             
 * 0x080B[15:0]  FIXREGSA3                   0                  0x0000           
 * 0x080D[7:0]   FIXREGSD3                   0                  0x00             
 * 0x080E[15:0]  FIXREGSA4                   0                  0x0000           
 * 0x0810[7:0]   FIXREGSD4                   0                  0x00             
 * 0x0811[15:0]  FIXREGSA5                   0                  0x0000           
 * 0x0813[7:0]   FIXREGSD5                   0                  0x00             
 * 0x0814[15:0]  FIXREGSA6                   0                  0x0000           
 * 0x0816[7:0]   FIXREGSD6                   0                  0x00             
 * 0x0817[15:0]  FIXREGSA7                   0                  0x0000           
 * 0x0819[7:0]   FIXREGSD7                   0                  0x00             
 * 0x081A[15:0]  FIXREGSA8                   0                  0x0000           
 * 0x081C[7:0]   FIXREGSD8                   0                  0x00             
 * 0x081D[15:0]  FIXREGSA9                   0                  0x0000           
 * 0x081F[7:0]   FIXREGSD9                   0                  0x00             
 * 0x0820[15:0]  FIXREGSA10                  0                  0x0000           
 * 0x0822[7:0]   FIXREGSD10                  0                  0x00             
 * 0x0823[15:0]  FIXREGSA11                  0                  0x0000           
 * 0x0825[7:0]   FIXREGSD11                  0                  0x00             
 * 0x0826[15:0]  FIXREGSA12                  0                  0x0000           
 * 0x0828[7:0]   FIXREGSD12                  0                  0x00             
 * 0x0829[15:0]  FIXREGSA13                  0                  0x0000           
 * 0x082B[7:0]   FIXREGSD13                  0                  0x00             
 * 0x082C[15:0]  FIXREGSA14                  0                  0x0000           
 * 0x082E[7:0]   FIXREGSD14                  0                  0x00             
 * 0x082F[15:0]  FIXREGSA15                  0                  0x0000           
 * 0x0831[7:0]   FIXREGSD15                  0                  0x00             
 * 0x0832[15:0]  FIXREGSA16                  0                  0x0000           
 * 0x0834[7:0]   FIXREGSD16                  0                  0x00             
 * 0x0835[15:0]  FIXREGSA17                  0                  0x0000           
 * 0x0837[7:0]   FIXREGSD17                  0                  0x00             
 * 0x0838[15:0]  FIXREGSA18                  0                  0x0000           
 * 0x083A[7:0]   FIXREGSD18                  0                  0x00             
 * 0x083B[15:0]  FIXREGSA19                  0                  0x0000           
 * 0x083D[7:0]   FIXREGSD19                  0                  0x00             
 * 0x083E[15:0]  FIXREGSA20                  0                  0x0000           
 * 0x0840[7:0]   FIXREGSD20                  0                  0x00             
 * 0x0841[15:0]  FIXREGSA21                  0                  0x0000           
 * 0x0843[7:0]   FIXREGSD21                  0                  0x00             
 * 0x0844[15:0]  FIXREGSA22                  0                  0x0000           
 * 0x0846[7:0]   FIXREGSD22                  0                  0x00             
 * 0x0847[15:0]  FIXREGSA23                  0                  0x0000           
 * 0x0849[7:0]   FIXREGSD23                  0                  0x00             
 * 0x084A[15:0]  FIXREGSA24                  0                  0x0000           
 * 0x084C[7:0]   FIXREGSD24                  0                  0x00             
 * 0x084D[15:0]  FIXREGSA25                  0                  0x0000           
 * 0x084F[7:0]   FIXREGSD25                  0                  0x00             
 * 0x0850[15:0]  FIXREGSA26                  0                  0x0000           
 * 0x0852[7:0]   FIXREGSD26                  0                  0x00             
 * 0x0853[15:0]  FIXREGSA27                  0                  0x0000           
 * 0x0855[7:0]   FIXREGSD27                  0                  0x00             
 * 0x0856[15:0]  FIXREGSA28                  0                  0x0000           
 * 0x0858[7:0]   FIXREGSD28                  0                  0x00             
 * 0x0859[15:0]  FIXREGSA29                  0                  0x0000           
 * 0x085B[7:0]   FIXREGSD29                  0                  0x00             
 * 0x085C[15:0]  FIXREGSA30                  0                  0x0000           
 * 0x085E[7:0]   FIXREGSD30                  0                  0x00             
 * 0x085F[15:0]  FIXREGSA31                  0                  0x0000           
 * 0x0861[7:0]   FIXREGSD31                  0                  0x00             
 * 0x090E[0]     XAXB_EXTCLK_EN              0                  0x0              
 * 0x0943[0]     IO_VDD_SEL                  0                  0x0              
 * 0x0949[3:0]   IN_EN                       1                  0x1              
 * 0x0949[7:4]   IN_PULSED_CMOS_EN           0                  0x0              
 * 0x094A[3:0]   INX_TO_PFD_EN               1                  0x1              
 * 0x094E[11:0]  REFCLK_HYS_SEL              585                0x249            
 * 0x095E[0]     MXAXB_INTEGER               0                  0x0              
 * 0x0A02[4:0]   N_ADD_0P5                   0                  0x00             
 * 0x0A03[4:0]   N_CLK_TO_OUTX_EN            7                  0x07             
 * 0x0A04[4:0]   N_PIBYP                     2                  0x02             
 * 0x0A05[4:0]   N_PDNB                      7                  0x07             
 * 0x0A14[3]     N0_HIGH_FREQ                0                  0x0              
 * 0x0A1A[3]     N1_HIGH_FREQ                0                  0x0              
 * 0x0A20[3]     N2_HIGH_FREQ                0                  0x0              
 * 0x0A26[3]     N3_HIGH_FREQ                0                  0x0              
 * 0x0B44[3:0]   PDIV_FRACN_CLK_DIS          3                  0x3              
 * 0x0B44[5]     FRACN_CLK_DIS_PLL           0                  0x0              
 * 0x0B46[3:0]   LOS_CLK_DIS                 0                  0x0              
 * 0x0B47[4:0]   OOF_CLK_DIS                 2                  0x02             
 * 0x0B48[4:0]   OOF_DIV_CLK_DIS             2                  0x02             
 * 0x0B4A[4:0]   N_CLK_DIS                   8                  0x08             
 * 0x0B57[11:0]  VCO_RESET_CALCODE           260                0x104
 * 
 *
 */

#endif