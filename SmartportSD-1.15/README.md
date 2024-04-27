# SmartportSD FAT version 1.15 - Mini version

NOTE: This version is designed to support the different pinout in the small version of the Smartport SD by Kero's Mac Mods. The pinout is different from the main project!

This is an enhancement of the [SmartportCFA/SmartportSD](http://www.users.on.net/~rjustice/SmartportCFA/SmartportCFA.htm) project by Robert Justice and Andrea Ottaviani. Instead of relying on four raw disk images written sequentially to an SD card, this version allows you to have up to four files on a FAT or FAT32 formatted SD card instead.

# Usage

## Get the code

Use git to clone the code and rename the enclosing folder to SmartportSD-1.15. (This is an annoying quirk of the Arduino environment, that requires the name of the code file to match the name of the folder it's in).

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

Name your images PART1.PO through PART4.PO. If you don't have four images that's OK, the missing ones will be skipped.

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
 
