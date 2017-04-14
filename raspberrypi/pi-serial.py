# Run this on the Raspberry Pi to control 3 coloured LEDs on the nodemcu

import serial

port = serial.Serial("/dev/serial0", baudrate=115200, parity=serial.PARITY_NONE, timeout=1.0)

port.write("dofile('serial.lua')\r\n")

for i in range(1,10):
    for c in ['r','g','b']:
    port.write(c)
        r = port.read(100)
        print(r)
