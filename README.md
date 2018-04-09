# ARBot
A built from scratch robot built using ARKit on an iPhone and an Arduino uno.

Wire Key:

1. Power from battery to Vin on Arduino
2. Ground from battery to GND on Arduino
3. Motor 1 PWM
4. Motor 2 PWM
5. Motor 3 PWM
6. Motor 4 PWM
7. 5V power for Bluetooth module from 5v rail on Arduino
8. Ground for Bluetooth module to ground on Arduino
9. Tx on Bluetooth to Some Pin on Arduino Designated as Tx (Not the Tx labeled port)
10. Rx on Bluetooth to Some Pin on Arduino Designated as Rx (Not the Rx labeled port)
11. State LED wire used to indicate Bluetooth connectivity to the Arduino

 

Power Route:

1. Battery powers the main rails on the board which directly powers the motors
2. Power from rails goes to Arduino and powers it using the Vin and GND ports
3. Power from the 5V rail on the Arduino powers the Bluetooth module

Summary: Battery -> Rails -> Arduino -> Battery Module

 

Parts:

· Arduino UNO

· HM-10 Bluetooth Module

 

Notes:

· The baud rate for the module is currently set to 115200, you will have to use that baud rate initially if you want to communicate with it and change it.

Helpful Links:

* http://www.martyncurrey.com/hm-10-bluetooth-4ble-modules/
* http://www.instructables.com/id/AT-command-mode-of-HC-05-Bluetooth-module/

The second link has commands that don't necesarily work I think. Also mess with the ending newline and tab when trying to send the commands to the bluetooth module to program it. You can configure lots of things like the name of the bluetooth module, baud rate, and some other stuff.
