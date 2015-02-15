


// Pull in the serial port interface. This requires pre-installation of the correct USB->serial drivers.
import processing.serial.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
PrintWriter output; 

Serial myPort;      // create the serial port variable
String header_string = "DateTime,Mote,Temp,Mic,RF,AQ,Motion";
int sensor_id=26;
int lf = 10;    // Linefeed in ASCII
String mystring=null;
String myReadOut=null;
String[] my_parse; //this is used in the parsing function at the bottom of this file.
int slices_i=0; //used when we need to seperate the files so they don't get too long.
int loopi=0;//used when we need to seperate the files so they don't get too long.
int sliceLength=3600; //3600 would be an hour (assuming a polling rate of 1sec aka 1000ms)


void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 9600); //May have to change the numeral in the serial list depending on the home computer hardware config.
  //motion_count = 0;
  delay(1000);
  myPort.write(':');//set AQ to off (or on,  if you change the command two down to 8. 
  myPort.write((char)sensor_id);
  myPort.write(9);//set AQ to off (or on,  if you change the command to 8. 
  println(header_string);
  //output = createWriter("moteData.csv");//moving this down to the loop so I can have more than one file
  //output.println(header_string);//
}

void draw () {

    myPort.write(':');
    myPort.write((char)sensor_id);
    myPort.write(02);//note, this changes depending on AQ sensor is on or off. switch to "1" if AQ is off, or "2" if it's on.
    mystring=myPort.readStringUntil(lf);
    delay(1000);
    if (mystring!=null){
        myReadOut=processString(sensor_id,mystring);
      };
   
  //AFTER THE CREATE READOUT
  if(loopi==0){
    slices_i++;
    println(slices_i);
    output=createWriter("moteData"+Integer.toString(slices_i)+".csv");
    output.println(header_string);
    if (myReadOut!=null){
        output.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
      print(myReadOut);  
      };
  } else if (loopi<sliceLength*slices_i){
    if (myReadOut!=null){
        output.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
    print(myReadOut);  
      };
  } else if(loopi==sliceLength*slices_i){
    slices_i++;
    println(slices_i);
    output.flush(); //write and close the last file
    output.close(); //write and close the last file
    output=createWriter("moteData"+Integer.toString(slices_i)+".csv");
    output.println(header_string);
    if (myReadOut!=null){
        output.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
      print(myReadOut);  
      };
  } else {
    output.flush();
    output.close();
    exit();
  };
loopi++;
}

void keyPressed() {
  output.flush();
  output.close();
  exit(); 
}

String processString(int the_id, String theString){ //function to convert response into csv
  int raw_temp=0;
  int motion_temp;
  String string_temp = "...";
  
  String[] sensor_values = new String[7]; //enough space for all the data we want
  if (theString!=null){
    sensor_values[0]=Integer.toString(month())+"/"+Integer.toString(day())+" "+Integer.toString(hour())+":"+Integer.toString(minute())+":"+Integer.toString(second());
    my_parse = splitTokens(theString,"\t ="); // the \t means tab. Split up the string put it into an array called "my_parse"
    sensor_values[1]=String.valueOf(the_id); // take the first argument passed in, place it at the start of the sensor_values array
    raw_temp = int(my_parse[1]);  // get the current temperature raw value string and convert to an int
    sensor_values[2] = str_convert_temp(raw_temp);  //move temperature post conversion into the array
    sensor_values[3]=my_parse[3]; //get the number for microphone (note.. what's this unit?)
    sensor_values[4]=my_parse[5]; //get the rf value. What's this unit?
    sensor_values[5]=my_parse[7]; // VOC value. What's the unit.
    sensor_values[6]=my_parse[9]; // Get the motion 
  };
  return join(sensor_values,",");// LOOK! a line of csv. MIGHT HAVE TO GET RID OF THE ","
}


// Use this function to get a Float
float convert_temp(int temp_sense)
{
  return float(nf(((((3.3 * float(temp_sense))/1024) - 0.6)*100), 2,2));
}

// Use this function to get a String
String str_convert_temp(int temp_sense)
{
  return nf(((((3.0  * float(temp_sense))/1024) - 0.6)*100), 2,2);
}

//function to parse numbers into  dbs, etc

//function to handle outages
//functions to handle many sensors
//functions to periodically write data to file .




