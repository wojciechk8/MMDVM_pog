This project is a hardware for the Multi-Mode Digital Voice Modem
([MMDVM](https://github.com/g4klx/MMDVM)). Instead of depending on
MCU development boards (like Arduino, STM Discovery, etc.), this design
contains a microcontroller itself, so no additional stuff is required.
This project is based on [SQ6POG](https://www.qrz.com/db/SQ6POG)'s idea,
and hence its name.

## Hardware 
The board contains STM32F105RBT MCU, two active low-pass filters: for
ADC and DAC. Additionally there is a place for an optional TCXO with
a buffer circuitry and LED indicators.

The PCB is prepared to be populated in two configurations listed below.
### Stand-alone
The board is populated with FT230XS USB-to-UART converter and 3.3V LDO

### As a Raspberry Pi HAT
This configuration is almost the same as previous, but with RPi
connector and without USB-to-UART converter and LDO.

## Building firmware
You can get the firmware from [MMDVM](https://github.com/g4klx/MMDVM)
github. The firmware can be built with the GNU ARM toolchain.
An additional requirement is the STM32CubeF1 package, which can be found
at STMicroelectronics website. Path to the CMSIS directory of
the extrected package should be adjusted in the Makefile.CMSIS as
CMSISDIR definition. Also uncomment these defines in the Config.h
file:
```
// For the SQ6POG board
#define STM32F1_POG
```
to enable MMDVM_pog board support,
```
// Pass RSSI information to the host
#define SEND_RSSI_DATA
```
to enable RSSI feature,
```
// Use pins to output the current mode
#define ARDUINO_MODE_PINS
```
to enable mode LEDs output,
```
// For 19.2 MHz
#define EXTERNAL_OSC 19200000
```
if you want to use external TCXO.

Be sure that defines regarding other boards are commented.

Finally to build the firmware simply run:
```
make -f Makefile.CMSIS
```

## Programming
### Via SWD
To program the device with SWD, run:
```
make -f Makefile.CMSIS program
```
(you will need *openocd* software and ST-LINK programmer).

### Via internal bootloader
If you don't have ST-LINK and want to use bootloader, then run:
```
make -f Makefile.CMSIS program_bl
```
(you will need *stm32flash* software; serial port can be selected
in the Makefile)


## Hacking
### Schematic/PCB
This project was designed using *gEDA* software. In order to modify
the schematic you will need my library of symbols/footprints, which is
available [here](https://github.com/wojciechk8/geda-sym). Update of
the PCB is done in the root directory with this command:
```
gsch2pcb mmdvm_pog.prj
```
Postscript and pdf export of PCB is done with:
```
./pcb_export mmdvm_pog.pcb
```

### Filter simulation
<p align="center"><img src="https://raw.githubusercontent.com/wojciechk8/MMDVM_pog/master/sim/plot/filter.png" alt="Filter frequency response simulation"></p>

The simulation of the filter (sim directory) was performed in *ngspice*
and the graphical plot output was generated using *gnuplot*. To run
the simulation use the script provided:
```
./simulate filter.sch
```

## License
This project is licensed under the CC-BY-NC-SA
(Creative Commons - Attribution, Noncommercial, Share Alike) license
and is intended for amateur and educational use only.

<p align="center"><img src="https://raw.githubusercontent.com/wojciechk8/MMDVM_pog/master/Cc-by-nc-sa_icon.png" alt="CC-BY-NC-SA"></p>

MMDVM software is licenced under the GPL v2 and is intended for amateur
and educational use only. Use of this software for commercial purposes
is strictly forbidden.
