# DarwinPrint
Klipper / OctoPrint installer for iOS \
⚠️ This is such an early release that not even the documentation is done! ⚠️\
**⚙️ Only a few iOS versions and printers are supported right now. I can only confirm that iOS 14 and an Ender 3 with a 4.2.7/4.2.2 mainboard work.**
A printer with CDC ACM communication or a CH341/CH340/HL340 chip should just work, and an iOS device with libusb support should just work.

## Experimental Install
First, make sure you're running on a Procursus bootstrapped jailbreak (you should have Sileo) \
Next, get a terminal on the device using something like SSH (or download NewTerm from Sileo) \
Run these commands in the terminal:
1. `sudo apt install git`
2. `git clone --recursive https://github.com/lotuspar/DarwinPrint.git`
3. `cd DarwinPrint`
4. `chmod +x Installer/start.sh && Installer/start.sh`

If it finished successfully you should have Klipper, OctoPrint & the usbselfserial loader. (if it didn't please make an issue) \
As there aren't any launch daemons set up during the install you have to run the tools from the terminal. (look at next section)

## Experimental Running
This is the way I use for testing while I haven't set up launch daemons. \

You need a way to run multiple terminals, so run:
```
sudo apt install tmux
```
### OctoPrint & Klippy
Then it's pretty painless to run OctoPrint and/or Klippy: 
```
tmux new-session -d -s octoprint /usr/bin/start-octoprint.sh
tmux new-session -d -s klippy /usr/bin/start-klippy.sh
```
To check up on them later (use CTRL+B -> D to detach): 
```
tmux attach-session -t octoprint
tmux attach-session -t klippy
``` 
### usbselfserial loader
To start a serial port to your printer you *need* usbselfserial loader. First get your printer vendor ID and product ID from lsusb (it shows as ID <vendor_id>:<product_id>). \
When you have this, try running uss_loader:
```
To start a serial port to your printer:
-> sudo uss_loader -v 0x(VENDOR_ID) -p 0x(PRODUCT_ID) -d ch34x -o /tmp/uss0 -r 250000
or sudo uss_loader -v 0x(VENDOR_ID) -p 0x(PRODUCT_ID) -d cdcacm -o /tmp/uss0 -r 250000

Make sure to use the right baudrate for your printer though:
-> for Marlin (probably) use -r 115200
-> for Klipper (probably) use -r 250000
```
You should also be able to run this like the other 2 (use CTRL+B -> D to detach):
```
tmux new-session -d -s uss uss_loader (arguments)
```
