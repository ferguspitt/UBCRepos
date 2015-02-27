// This code is be Fergus Pitt, writted primarily as a teaching tool for a seminar at the University of British Columbia Journalism School 
// It shares some early DNA with KippKitt's code from: https://github.com/kippkitts/DataSensingLab/tree/master/ONA_Sensor_Mote


// Pull in the serial port interface. This requires pre-installation of the correct USB->serial drivers.
import processing.serial.*;
import java.io.BufferedWriter;
import java.io.FileWriter;

PrintWriter output1; //This seems excessive and messy, if I have time, I'll refactor.
PrintWriter output2;
PrintWriter output3;
PrintWriter output4;
PrintWriter output5;
PrintWriter output6;
PrintWriter output7;
PrintWriter output8;
PrintWriter output9;
PrintWriter output10;


Serial myPort;      // create the serial port variable
String header_string = "DateTime,Mote,Temp,Mic,RF,AQ,Motion";

int sensor_limit=11;

int lf = 10;    // Linefeed in ASCII

String[] my_parse; //this is used in the parsing function at the bottom of this file.
int slices_i=0; //used when we need to seperate the files so they don't get too long.
int loopi=0;//used when we need to seperate the files so they don't get too long.
int sliceLength=514; //3600/sensorlimit would be an hour (assuming a polling rate of 1sec aka 1000ms)


void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600); //May have to change the numeral in the serial list depending on the home computer hardware config.
  //motion_count = 0;
  delay(1000);

  
  
  for (int sensor_id=1; sensor_id<sensor_limit; sensor_id=sensor_id+1){
    myPort.write(':');//set AQ to off (or on,  if you change the command two down to 8. 
      myPort.write((char)sensor_id);
    myPort.write(8);//9 setS AQ to off (or on,  if you change the command to 8. 
      println(header_string);
      println(sensor_id);
  //output = createWriter("moteData.csv");//moving this down to the loop so I can have more than one file
  //output.println(header_string);//
    }
}

void draw () {




    //AFTER THE CREATE READOUT
    if(loopi==0){
      slices_i++;
      print("slice: ");
      print(slices_i);
      output1=createWriter("1moteData"+Integer.toString(slices_i)+".csv");
      output1.println(header_string);
      output2=createWriter("2moteData"+Integer.toString(slices_i)+".csv");
      output2.println(header_string);
      output3=createWriter("3moteData"+Integer.toString(slices_i)+".csv");
      output3.println(header_string);
      output4=createWriter("4moteData"+Integer.toString(slices_i)+".csv");
      output4.println(header_string);
      output5=createWriter("5moteData"+Integer.toString(slices_i)+".csv");
      output5.println(header_string);
      output6=createWriter("6moteData"+Integer.toString(slices_i)+".csv");
      output6.println(header_string);
      output7=createWriter("7moteData"+Integer.toString(slices_i)+".csv");
      output7.println(header_string);
      output8=createWriter("8moteData"+Integer.toString(slices_i)+".csv");
      output8.println(header_string);
      output9=createWriter("9moteData"+Integer.toString(slices_i)+".csv");
      output9.println(header_string);
      output10=createWriter("10moteData"+Integer.toString(slices_i)+".csv");
      output10.println(header_string);
      loopThroughSensors();





    } else if (loopi<sliceLength*slices_i){
      loopThroughSensors();
    } else if(loopi==sliceLength*slices_i){
      slices_i++;
      println(slices_i);
      output1.flush(); //write and close the last file
      output1.close(); //write and close the last file
      output1=createWriter("1moteData"+Integer.toString(slices_i)+".csv");
      output1.println(header_string);
      output2.flush(); //write and close the last file
      output2.close(); //write and close the last file
      output2=createWriter("2moteData"+Integer.toString(slices_i)+".csv");
      output2.println(header_string);  
      output3.flush(); //write and close the last file
      output3.close(); //write and close the last file
      output3=createWriter("3moteData"+Integer.toString(slices_i)+".csv");
      output3.println(header_string);
      output4.flush(); //write and close the last file
      output4.close(); //write and close the last file
      output4=createWriter("4moteData"+Integer.toString(slices_i)+".csv");
      output4.println(header_string);
      output5.flush(); //write and close the last file
      output5.close(); //write and close the last file
      output5=createWriter("5moteData"+Integer.toString(slices_i)+".csv");
      output5.println(header_string);
      output6.flush(); //write and close the last file
      output6.close(); //write and close the last file
      output6=createWriter("6moteData"+Integer.toString(slices_i)+".csv");
      output6.println(header_string);
      output7.flush(); //write and close the last file
      output7.close(); //write and close the last file
      output7=createWriter("7moteData"+Integer.toString(slices_i)+".csv");
      output7.println(header_string);
      output8.flush(); //write and close the last file
      output8.close(); //write and close the last file
      output8=createWriter("8moteData"+Integer.toString(slices_i)+".csv");
      output8.println(header_string);  
      output9.flush(); //write and close the last file
      output9.close(); //write and close the last file
      output9=createWriter("9moteData"+Integer.toString(slices_i)+".csv");
      output9.println(header_string);  
      output10.flush(); //write and close the last file
      output10.close(); //write and close the last file
      output10=createWriter("9moteData"+Integer.toString(slices_i)+".csv");
      output10.println(header_string);
      loopThroughSensors();
    } else {
      output1.flush();
      output1.close();
      output2.flush();
      output2.close();
      output3.flush();
      output3.close();
      output4.flush();
      output4.close();
      output5.flush();
      output5.close();
      output6.flush();
      output6.close();
      output7.flush();
      output7.close();
      output8.flush(); //write and close the last file
      output8.close();
      output9.flush(); //write and close the last file
      output9.close();
      output10.flush(); //write and close the last file
      output10.close();
      
      exit();
    };
    loopi++;

    //delay(1000);  


}

void keyPressed() {
      output1.flush();
      output1.close();
      output2.flush();
      output2.close();
      output3.flush();
      output3.close();
      output4.flush();
      output4.close();
      output5.flush();
      output5.close();
      output6.flush();
      output6.close();
      output7.flush();
      output7.close();
      output8.flush();
      output8.close();
      output9.flush();
      output9.close();
      output10.flush();
      output10.close();
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
float convert_temp(int temp_sense){
  return float(nf(((((3.3 * float(temp_sense))/1024) - 0.6)*100), 2,2));
}

// Use this function to get a String
String str_convert_temp(int temp_sense){
  return nf(((((3.0  * float(temp_sense))/1024) - 0.6)*100), 2,2);
}


void loopThroughSensors(){

  for (int sensor_id=1; sensor_id<sensor_limit; sensor_id=sensor_id+1){
    String mystring=null;
    String myReadOut=null; 
    myPort.write(':');
    myPort.write((char)sensor_id);
    myPort.write(02);//note, this changes depending on AQ sensor is on or off. switch to "1" if AQ is off, or "2" if it's on.
    mystring=myPort.readStringUntil(lf);
    print("Sensor ID: ");
    print(sensor_id);
    print("   :");
    
    if (mystring!=null){
      myReadOut=processString(sensor_id,mystring);
    };
    if (myReadOut!=null){
      if (sensor_id==1){
        output1.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==2){
        output2.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      }; 
      if (sensor_id==3){
        output3.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==4){
        output4.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==5){
        output5.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==6){
        output6.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==7){
        output7.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==8){
        output8.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==9){
        output9.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };
      if (sensor_id==10){
        output10.print(myReadOut); //in here to take care of returned empty data. Might need to allow for dropped rows....come back later
        println(myReadOut);
      };  
       
    };
    delay(1000); 
  };
       
}


//function to parse numbers into  dbs, etc
//function to handle outages





