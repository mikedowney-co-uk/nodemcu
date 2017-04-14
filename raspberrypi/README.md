# Connecting the Rasperry Pi to NodeMCU using the Serial Port

Here are some examples of code to connect the Pi to the NodeMCU using the serial port. The NodeMCU has 3 LEDs attached to GPIO pins
1,2 and 3. The Pi sends either 'r','g' or 'b' to light the appropriate LED, or any other character to turn them off.

## Setting up the Pi

Mode details and photos are on [my website](http://www.mikedowney.co.uk/blog/computing/raspberry_pi/nodemcu_serial.html).


By default, the serial port on the Pi is configured to be used for a serial console , mainly for diagnostics.
To use it for other things, you need to disable the console. To do this, edit  the /boot/config.txt file and add the line

<pre>enable_uart=1</pre>

then edit root/cmdline.txt and remove the

<pre>console=serial0,115200</pre>

line. After rebooting the Pi, the GPIO pins 14 & 15 should be available for the serial port.
