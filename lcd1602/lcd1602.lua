-- Write to the 1602 screen
-- Based on the Adafruit python code

-- Pin Definitions
RS = 1
CLK = 2

pins={7,6,5,4}

-- Set up the out pins
function setupPins()
     gpio.mode(RS,gpio.OUTPUT)
     gpio.mode(CLK,gpio.OUTPUT)
     for i=1,4 do
          gpio.mode(pins[i],gpio.OUTPUT)
     end    
end

function resetPins()
     for i=1,4 do
          gpio.write(pins[i],gpio.LOW)
     end
end

function sendClock()
     gpio.write(CLK,gpio.LOW)
     gpio.write(CLK,gpio.HIGH)
     gpio.write(CLK,gpio.LOW)
end

function sendbyte(b,charmode)
     gpio.write(RS,charmode)

     -- shift right 4 times putting the bits on the output lines
     mask=128
     for c=1,2 do
         for i=1,4 do
              r = bit.band(b,mask)
              if r==0 then
                   gpio.write(pins[i],gpio.LOW)
              else
                   gpio.write(pins[i],gpio.HIGH)
              end
              mask = mask / 2
          end
          sendClock()
      end
end


function clearPanel()
     sendbyte(0x01,gpio.LOW)
     tmr.delay(10)
end


function line2()
     sendbyte(0xC0,gpio.LOW)
end

-- Methods to send the characters to the screen, using a timer and callback.

buffer = {}

-- byte 13 (newline) moves to line 2

function bufferText(text)
     for i=1,string.len(text) do
        table.insert(buffer,string.byte(text,i))
        if i=="\n" then newline() end
    end
end

function newline()
     table.insert(buffer,"\n")
end

-- Empty buffer and clear display
function clearBuffer()
     buffer = {}
     clearPanel()
end

function sendNextByte()
     if table.getn(buffer)>0 then
          byte = table.remove(buffer,1)
          if byte == "\n" then
               line2()
          else
               sendbyte(byte,gpio.HIGH)
          end
     end
end


-- START
-- Initialise the board
setupPins()
resetPins()

-- Initialise the display (low = command mode, high = character mode)
-- 0b0011 twice (as per Wikipedia)
sendbyte(0x33,gpio.LOW)
-- another 0b0011 then the 0b0010 to put it in 4 bit mode.
sendbyte(0x32,gpio.LOW)
sendbyte(0x28,gpio.LOW)
sendbyte(0x0C,gpio.LOW)

lcdtimer=tmr.create()
lcdtimer:register(10,tmr.ALARM_AUTO,sendNextByte)
lcdtimer:start()

clearBuffer()
-- To send text, use
bufferText("A Line")
newline()
bufferText("Another Line")

