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

You can flash your Arduino Nano via ArduinoIDE. Please download and use firmware of "SmartportSD-1.15 2" folder. If a new folder is created when using the Arduino IDE, please re-insert all the contents of this "SmartportSD-1.15 2" folder into the new folder.<BR>
<BR>
The Nano board you should choose is MEGA328P. Please do not buy MEGA168P as it has 38% insufficient capacity and cannot be flashed.<BR>
<img src="SD2SD_PIX/IMG_7158.jpeg" width="520px"><BR>
The Arduino IDE settings are as follows,<BR>
Board: "Arduino Nano"<BR>
Processor: "ATmega328P(Old Bootloader)"<BR>
Programmer: "AVRISP mkII"<BR>

## Assemble
Uploaded on Sep 24, assembly instructions can be found [here](SP2SD_DIY_INST.pdf), You can see which parts should be attached where by looking at our [BOM](SP2SD_NANO_DIY_BOM.csv). 
<BR>
<img src="SD2SD_PIX/IMG_6993.jpeg" width="320px">
<BR>
The IDC20 connector can be oriented in various ways depending on how you use it, When installing the male IDC20pin connector, be sure to make sure that the part is on the top side. When stacking two PCBs, make sure the hole and ▼ are in the same position. In that case, match the IDC20pin male and female connectors or connect them with a 2X10 pin header.

## DB19 male connector

You can 3D print the base material and pull out the pins from a [DB25 male connector](https://www.amazon.com/PC-Accessories-Connectors-Connector-25-PACK/dp/B073KR622F/ref=sr_1_2_sspa?crid=2ZCRZ8PNIBJ4R&keywords=DB25+connector+male&qid=1693987417&sprefix=db25+connector+mal%2Caps%2C398&sr=8-2-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1) and insert them, or purchase new pins from [AliExpress](https://www.aliexpress.com/item/1005002617586407.html?spm=a2g0o.order_list.order_list_main.16.55d11802jCHaOW). We have omitted unnecessary pins to make it simple for you to create. I will give out free .STL files that can be 3D printed. <BR><BR> DB19 connector file is [this](KEROS_DB19_V1.zip).


## Supported Apple II computers

<BR>
<img src="SD2SD_PIX/IMG_6963.jpeg" width="360px">

<BR><BR>
- Apple IIgs<BR>
- Apple IIc, IIc Plus *In the case of IIc, Smartport cannot be used as is with older ROM 255, so a ROM upgrade is required. See the chapter bellow
- Apple IIe, IIe Enhanced, IIe Platinum *you can use it via Expansion cards like "Liron" card, or insert the DIY SoftSP card*(1) into the #5 slot and use it via the DiskII card in the #6 slot. BMOW also has a highly functional card called "Yellowstone", which can also be used. <BR>
*For the II Plus, There are still many untested parts. A card like IIe would probably work. Please use at your own risk, as there are still things we don't understand or haven't tried.<BR>

(1) About a SoftSP DIY, My test results ROM revisions V2 and V3 worked with IIe, but they doesn't work well with II Plus. In the V5 and V6, I/O errors occur with IIe, of course it doesn't work on II Plus. There's probably a timing issue. <BR><BR>

## Usage
<BR>
Use a FAT32 formatted MicroSD card. Most of the MicroSD cards currently on sale can be used as is.
Extension .po files can be used.<BR><BR>
The disk image that can be used for SP2SD is a .PO file with a maximum size of 32MB. Place this file at the root of your micro SD card. Up to 4 files can be recognized. The first file name should be “PART1.PO”. As you can imagine, there can place four files, so from the second file on, name the files with regularity, such as "PART2.PO", "PART3.PO", and "PART4.PO".<BR>
If your disk image is in .HDV format, If the extension is .hdv, the catalog structure is the same, so you should be able to use it by simply changing the file name to .po. CiderPress V4 can also be used with other extensions.
I think the most popular way to use SP2SD on the IIc is to use TotalReplay, a collection of old appleII games. <BR>
The IIgs supports GSOS. In this case, you can check all four files at the same time on the OS's finder. If you only have a IIgs, the SP2SD is the device with the best value for money.<BR><BR>
*If you change the extension from .hdv to .po and it doesn't work, you can use CiderPress to convert it to a .PO file. CiderPressV4 can be done on Windows 7 and up. *For Win98/ME/2K/XP there is an older version.<BR>
<BR>
CiderPress V4:<BR>(https://a2ciderpress.com)<BR><BR>
TotalReplay:<BR>(https://archive.org/details/TotalReplay<BR><BR>
 



## To use Apple IIc's smart port
For Apple IIc, Smartport will not be enabled if ROM 255 is installed. To check the ROM of your IIc, run the following program from the Basic prompt.
  PRINT PEEK (64447)
If the output number is "255", the ROM needs to be replaced. The ROM versions that Smartport can use are "0", "3" and "4". For these numbers, ROM replacement is not necessary.

The replaced ROMs are available [here](https://mirrors.apple2.org.za/Apple%20II%20Documentation%20Project/Computers/Apple%20II/Apple%20IIc/ROM%20Images/).
There is also the useful hacked [ROM4X](https://github.com/mgcaret/rom4x).

My recommendation is ROM4X.

If you want to swap the ROM from 255 to another ROM, you need to change the solder jumpers "W1" and "W2". 
255 is 16KB while other ROMs are 32KB. Enable 32KB by changing Pin27, which is A14, from pull-down to pull-up. 
See below for solder jumper locations. [External site](https://www.apple2faq.com/apple2faq/apple-iic-rom-upgrade/?fbclid=IwAR3BZfkTRkhG0zg6dHxvxYdH9SbyCvsA-Zr1-_e0wyenW6WFG-cKSsxj_oM)

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

