# SP2SD_DIY_KIT
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
<br>
<img src="SD2SD_PIX/IMG_7010.jpeg" width="520px">
# What kind of product is this
It is based on an open source project called SmartPortSD. 
Created by Australian genius [Robert Justice](https://web.archive.org/web/20230222233834/http://www.users.on.net/~rjustice/SmartportCFA/SmartportCFA.htm), SmartPortCFA was ported to Arduino hardware by Italian programmer genius [Andrea Ottaviani](https://github.com/aotta?fbclid=IwAR0_7cMKVhMVrHznB9bIub9ZmrmBlwAM3p6-_CQd0JFW1o736nUNZHyuTdw).  to porting to Arduino hardware. It was improved upon by [Katherine Stark](https://gitlab.com/nyankat/smartportsd) of Canada. She made available its ability to access four ProDOS-formatted 32MB PO files stored on a FAT32-formatted SD card. When she did this successfully, many wanted to build it.

*Got permission from the three geniuses I introduced earlier.

<BR>
More details here (My Blog):
https://ameblo.jp/keroxiee1016/entry-12819341808.html

## Flashing Arduino Nano

You can flash your Arduino Nano via ArduinoIDE. Please download and use firmware of "SmartportSD-1.15 2" folder. If a new folder is created when using the Arduino IDE, please re-insert all the contents of this "SmartportSD-1.15 2" folder into the new folder.

The Nano board you should choose is MEGA328P. Please do not buy MEGA168P as it has 38% insufficient capacity and cannot be flashed.

The Arduino IDE settings are as follows,
Board: "Arduino Nano"
Processor: "ATmega328P(Old Bootloader)"
Programmer: "AVRISP mkII"

## Assemble

Under constructions, You can see which parts should be attached where by looking at our [BOM](SP2SD_NANO_DIY_BOM.csv). The diode has polarity, so match the line and K. Flip the MicroSD board face down and either straighten the right angle pin headers or replace them with vertical pin headers.
<BR>
<img src="SD2SD_PIX/IMG_6993.jpeg" width="320px">
<BR>
The IDC20 connector can be oriented in various ways depending on how you use it, When installing the male IDC20pin connector, be sure to make sure that the part is on the top side. When stacking two PCBs, make sure the hole and ▼ are in the same position. In that case, match the IDC20pin male and female connectors or connect them with a 2X10 pin header.

## DB19 male connector

You can 3D print the base material and pull out the pins from a [DB25 male connector](https://www.amazon.com/PC-Accessories-Connectors-Connector-25-PACK/dp/B073KR622F/ref=sr_1_2_sspa?crid=2ZCRZ8PNIBJ4R&keywords=DB25+connector+male&qid=1693987417&sprefix=db25+connector+mal%2Caps%2C398&sr=8-2-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1) and insert them, or purchase new pins from [AliExpress](https://www.aliexpress.com/item/1005002617586407.html?spm=a2g0o.order_list.order_list_main.16.55d11802jCHaOW). We have omitted unnecessary pins to make it simple for you to create. I will give out free .STL files that can be 3D printed. DB19 connector file is [this](KEROS_DB19_V1.zip).


## Supported Apple II computers

<BR>
<img src="SD2SD_PIX/IMG_6963.jpeg" width="360px">

<BR><BR>
- Apple IIgs<BR>
- Apple IIc, IIc Plus *In the case of IIc, Smartport cannot be used as is with older ROM 255, so a ROM upgrade is required. The easiest way is to flash [ROM4X](https://github.com/mgcaret/rom4x) yourself. [Here](https://www.apple2faq.com/apple2faq/apple-iic-rom-upgrade/?fbclid=IwAR3BZfkTRkhG0zg6dHxvxYdH9SbyCvsA-Zr1-_e0wyenW6WFG-cKSsxj_oM) is the information.<BR>
- Apple IIe, IIe Enhanced, IIe Platinum *you can use it via Expansion cards like "Liron" card, or insert the DIY SoftSP card*(1) into the #5 slot and use it via the DiskII card in the #6 slot. BMOW also has a highly functional card called "Yellowstone", which can also be used. <BR>
*For the II Plus, There are still many untested parts. A card like IIe would probably work. Please use at your own risk, as there are still things we don't understand or haven't tried.<BR>

(1) About a SoftSP DIY, My test results ROM revisions V2 and V3 worked with IIe, but they doesn't work well with II Plus. In the V5 and V6, I/O errors occur with IIe, of course it doesn't work on II Plus. There's probably a timing issue. <BR><BR>

## To get the SP2SD PCB

You can use [SPSD_DIY_NANO_GERBER.zip](SPSD_DIY_NANO_GERBER.zip)  and uploading it to JLCPCB or PCBWAY as it is.

<BR>
<img src="SD2SD_PIX/PCB_TOP.png" width="600px">

<INS>Bare PCB will be sold in our [store](https://en.infinityproducts.co.jp/shop-1). If you are having trouble ordering a PCB or are not used to it, please contact us.
*It will be available in our stores in late September 2023.<INS>


## Licenses

SmartportSD software licenses are listed [here](SMARTPORTSD_LICENSE.md) under the MIT license.
Ⓒ2023 Katherine Stark, Robert Justice, Andrea Ottaviani. All rights reserved.

This SP2SD hardware is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).
Ⓒ 2023 Kay Koba, Kero's mac Mods, All rights reserved.
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

