// Pull in the serial port interface. This requires pre-installation of the correct USB->serial drivers.
import processing.serial.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
PrintWriter output; 
Serial myPort;      // create the serial port variable
String mystring=null;
String header_string="Time Stamp, Noise Level, Humidity, Temperature (*C)";


void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600); //May have to change the numeral in the serial list depending on the home computer hardware config.
  //motion_count = 0;
  delay(1000);
  println("hello world");
  delay(1000);
  output = createWriter("NoiseHumTempData.csv");
  output.println(header_string);//
}

void draw(){
  if ( myPort.available() > 0) 
  {  // If data is available,
  mystring = myPort.readStringUntil('\n');         // read it and store it in val
  
  } 
  if (mystring!=null)
  {
    println(mystring);
    String[] values = split(mystring,",");
    if(values.length==3)
    {
      String timeStamp=Integer.toString(month())+"/"+Integer.toString(day())+" "+Integer.toString(hour())+":"+Integer.toString(minute())+":"+Integer.toString(second())+",";
      output.print(timeStamp+mystring);
    }
  } 
  delay(1000);
}

void keyPressed() {
  output.flush();
  output.close();
  exit(); 
}


