-- Listen on the serial port for a colour.
-- Toggle the colour of the LED.

green=2
blue=1
red=3
gpio.mode(red,gpio.OUTPUT)
gpio.mode(green,gpio.OUTPUT)
gpio.mode(blue,gpio.OUTPUT)

-- Start with the LEDs off
gpio.write(red,gpio.LOW)
gpio.write(green,gpio.LOW)
gpio.write(blue,gpio.LOW)

uart.setup(0,115200,8, uart.PARITY_NONE, uart.STOPBITS_1, 1)

uart.on("data",1,
    function(char)
        if char=="r" then
            print("red")
            gpio.write(red,gpio.HIGH)
            gpio.write(green,gpio.LOW)
            gpio.write(blue,gpio.LOW)
        elseif char=="g" then 
            print("green")
            gpio.write(red,gpio.LOW)
            gpio.write(green,gpio.HIGH)
            gpio.write(blue,gpio.LOW)
            lighton=2
        elseif char=="b" then
            print("blue")
            gpio.write(red,gpio.LOW)
            gpio.write(green,gpio.LOW)
            gpio.write(blue,gpio.HIGH)
        else
            print("Off")
            gpio.write(red,gpio.LOW)
            gpio.write(green,gpio.LOW)
            gpio.write(blue,gpio.LOW)
        end
    end,0)
