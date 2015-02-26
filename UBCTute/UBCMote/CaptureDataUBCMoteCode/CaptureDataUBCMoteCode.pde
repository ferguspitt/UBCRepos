// Pull in the serial port interface. This requires pre-installation of the correct USB->serial drivers.
import processing.serial.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
PrintWriter output; 
Serial myPort;      // create the serial port variable
String mystring=null;
String header_string="DateTime,Mic,Humidity,Temp";
int slices_i=0; //used when we need to seperate the files so they don't get too long.
int loopi=0;//used when we need to seperate the files so they don't get too long.
int sliceLength=3600; //3600 would be an hour (assuming a polling rate of 1sec aka 1000ms)

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600); //May have to change the numeral in the serial list depending on the home computer hardware config.
  //motion_count = 0;
  delay(1000);
  println("hello world");
  delay(1000);

}

void draw(){
  String results=compileData();
  

  
  if(loopi==0){
    slices_i++;
    println(slices_i);
    output=createWriter("NoiseHumTempData"+Integer.toString(slices_i)+".csv");
    output.println(header_string);
    if (results!=null){output.print(results);};
  } else if (loopi<sliceLength*slices_i){
    if (results!=null){output.print(results);} 
  } else if(loopi==sliceLength*slices_i){
    slices_i++;
    println(slices_i);
    output.flush(); //write and close the last file
    output.close(); //write and close the last file
    output=createWriter("NoiseHumTempData"+Integer.toString(slices_i)+".csv");
    output.println(header_string);
    if (results!=null){output.print(results);}
  } else {
    output.flush();
    output.close();
    exit();
  };
loopi++;
delay(1000); 
}

void keyPressed() {
  output.flush();
  output.close();
  exit(); 
}



String compileData(){
  String data=null;
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
        data=timeStamp+mystring;
      }
    } 
  return data;
}

