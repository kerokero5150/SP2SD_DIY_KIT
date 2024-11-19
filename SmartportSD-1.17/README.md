# SmartportSD FAT version 1.17

This is an enhancement of the [SmartportCFA/SmartportSD](http://www.users.on.net/~rjustice/SmartportCFA/SmartportCFA.htm) project by Robert Justice and Andrea Ottaviani. Instead of relying on four raw disk images written sequentially to an SD card, this version allows you to have up to four files on a FAT or FAT32 formatted SD card instead.

version 1.17: Improved version by Wing Yeung from [MFA2 work shop](http://www.mfa2lab.com). version 1.16 has been thoroughly tested with "SPIISD" hardware and has confirmed good performance.This same 1.16 program can work with both "SPIISD DIY KIT" and "SPIISD MINI". V1.17 adds support for IIcPlus. Memory allocation has been changed to dynamic allocation.

*We have not verified SmartportSD compatible devices from other manufacturers. I think they work well if they keep the same schematics.

# Usage

## Get the programs

Download it on [SPIISD](https://github.com/kerokero5150/SP2SD_DIY_KIT)'s Github. Copy and use the "SmartportSD-1.16" folder as is.

## Get the dependencies

Download the latest version of the [SdFat Arduino library](https://github.com/greiman/SdFat/) and install it in your Arduino libraries folder (that location is system-dependent so you'll have to figure out where it is for you, sorry).

## Compile and upload the code to the Arduino

## Wire up the Arduino

Follow the instructions on [Robert's page](http://www.users.on.net/~rjustice/SmartportCFA/SmartportSD.htm) for the wiring diagram.

### WARNING

Don't connect the Arduino USB and the +5V power to the Apple computer at the same time! Doing so could lead to a situation where +5V is backfeeding into the Apple from the Arduino, which is bad. 

If you plan on doing development work on this, or just want to watch the Arduino serial console for error messages, disconnect the +5V connection between the Apple II and the Arduino and power it only via the USB port. 

#### Technical details
The Apple needs more than the 500mA your modern computer's USB power supply can provide to boot up, plus it needs some other voltages as well. You could end up burning out your Arduino, your USB port, your Apple, or all of the above! (The most likely thing to happen is the USB port might shut off, or the Arduino will get hot and annoyed, though).

## Place images on the SD card

You can place unlimited images in the root or subfolders of the SD card. However, only the four files specified in config.txt can be mounted.
By placing "config.txt" at the root of the SD card, you can place various files without renaming them.
Write 4x file names in "config.txt". SPIISD will only read files with that filename.
In addition to ".po", ".hdv" and ".2mg" can be used as extensions.
If config.txt is not in the root, Name your images PART1.PO through PART4.PO. If you don't have four images that's OK, the missing ones will be skipped.

### NOTE

Images must be unadorned ProDOS-order images. They don't have to be ProDOS file systems though - ISO9660, DOS 3.3 and HFS should work (although they are currently untested).

## Change boot  order, if you want

The eject button, if you have it wired up, will work the same way as it does in Robert's version of the code. Hold the button down while power cycling the Apple (or pressing the Arduino reset button if the USB connection is supplying power) to choose the next of the four images as the new startup disk. Then power cycle (or reset) the Arduino again without the button held down to get ready for the next boot.

### WARNING

Make sure you have a pulldown resistor to ground on the eject button pin (Analog pin 3). If you don't, the Arduino will assume the button is always being held down and keep changing the boot device and never start its normal operation. Ask me how much debugging trouble this caused me!

## Boot the machine!

That's it, turn on the machine and it should boot from PART1.PO!

## BUGS

- The combination of this device, a ROM 03 IIgs, and a CFFA3000 card seems to  prevent booting from this device. If you have this setup, please test it and report back to me.
- The code for switching boot partitions is probably going to fail if files get renamed so that a previously present boot partition goes away.

Please report bugs or comment on the above via the GitLab issues page for the project.

April 27, 2024, Ver 1.16 edited by Kay Koba, Kero's Mac Mods 

(C) SmartportSD Project
 
