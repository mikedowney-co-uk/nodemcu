// Run on the Raspberry Pi to talk to the nodemcu
// Get the serial library using sudo apt-get install librxtx-java
// Compile using javac -cp /usr/share/java/RXTXcomm.jar:. SerialTest.java
// Run using java -cp /usr/share/java/RXTXcomm.jar:. -Djava.library.path=/usr/lib/jni SerialTest

import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.SerialPort;

import java.io.*
import java.util.Scanner;

public class SerialTest{

    public static void main(String[] args) throws Exception{
        CommPortIdentifier portIdentifier = CommPortIdentifier.getPortIdentifier("/dev/ttyS0");
        CommPort commPort = portIdentifier.open("Java Serial Test",1000);
        System.out.println("Opened Port");

        SerialPort serialPort = (SerialPort) commPort;
                serialPort.setSerialPortParams(115200,SerialPort.DATABITS_8,SerialPort.STOPBITS_1,SerialPort.PARITY_NONE);

        String[] leds = new String[]{"r","g","b","off"};

                try(BufferedInputStream in = new BufferedInputStream(serialPort.getInputStream());
                BufferedOutputStream out = new BufferedOutputStream(serialPort.getOutputStream());
        Scanner s = new Scanner(in)){

            for(String c : leds){
                out.write(c.getBytes());
                out.flush();
                System.out.println(s.next());
                Thread.sleep(1000);
            }
        }
    }
}
