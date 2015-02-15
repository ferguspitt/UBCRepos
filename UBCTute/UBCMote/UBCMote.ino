//UBC Sketch, Demo audio level, temp humidity, combines DHT tester by ladyada and, sound level sketch by adafruit.

////////////////////////////////////////////////////////////////////////////////////////////////////////
// Initialize by ask the arduino authoring progam to pull in some libraries and setting some variables .//////
////////////////////////////////////////////////////////////////////////////////////////////////////////
// Make sure you've installed the DHT library! Get it from https://github.com/adafruit/DHT-sensor-library
#include "DHT.h" //import the library
#define DHTPIN 2     // what pin we've connected the sensor data output to: Number "2" in the digital side.
#define DHTTYPE DHT11   // DHT 11. If you have the wrong sensor defined, you'll see crazy big reading.
DHT dht(DHTPIN, DHTTYPE); // Initialize DHT sensor for normal 16mhz Arduino (the Uno is runs at 16mhz)

// initialize for the audio
const int sampleWindow = 50; // Sample window width in mS (50 mS = 20Hz)
unsigned int sample; //we're making a *positive* number variable

////////////////////////////////////////////////////////////////////////////////////
// Ask the mote to do some things, but only once, at the start of the program.//////
////////////////////////////////////////////////////////////////////////////////////

void setup() {// this is the startup sequence for the arduino code. 
  Serial.begin(9600);


  //    Serial.println("DHT testing"); //turn this on for a "hello world".
  dht.begin();// calls a library function for the temp/humidity

}

//////////////////////////////////////////////////////////////////////////
// and this is where the mote starts collecting and outputting data.//////
//////////////////////////////////////////////////////////////////////////

void loop(){ //Arduino runs on loops. We'll just repeat everthing in here, until the unit stops getting power.
  unsigned long startMillis=millis();//define the start of the sample window
  unsigned int peakToPeak =0;// a container for the level between peaks
  unsigned int signalMax = 0; //this is because an unsigned int will go up to 0 then roll over 
  unsigned int signalMin = 1024;

  while(millis()-startMillis<sampleWindow){
    sample=analogRead(0);
    if(sample<1024){// LOOK AT THIS, We're making decisions about getting rid of some data, based on an expectation of what the sensor "should" produce
      if(sample>signalMax){
        signalMax=sample; //save just the max level
      }
      else if (sample<signalMin){
        signalMin=sample; //save just the minimum level
      }
    }
  }
  peakToPeak=signalMax-signalMin; // max - min = peak-peak amplitude
  float current = (peakToPeak * 3.3) / 10.24;  // convert to volts (And multiply by ten to display more precision)
  //    Serial.print("Noise level:"); //Take these out so we can get a csv
  Serial.print(current);
  Serial.print(",");
  //  Serial.print("\n"); //Take these out so we can get a csv



  //Temp & Humidity looped code starts.
  float h = dht.readHumidity(); //call a function from the DHT sensor library, assign the output to a variable "h" (which is a float: a number with the decimal point anywhere it needs to be.)
  float t = dht.readTemperature(); // same idea as above, just calling a different function.
  //    float f = dht.readTemperature(true); // call the temp function, but pass an "argument" which says give me the number in fahrenheit (because America)

  // Check if any reads failed (by checking for NaN: Not a number) and exit early (to try again).
  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!,.,"); //Tell us something went wrong
    return;
  }
  //float hi = dht.computeHeatIndex(f, h); //this computes the "heat index" http://en.wikipedia.org/wiki/Heat_index, using the Fahrenheit and Humidity as inputs. We're not going to use it for the moment
  Serial.print(h);
  Serial.print(",");
  Serial.print(t);
  Serial.print(",");

  Serial.print("\n");
  // Temp and humidity looped code ends.


  delay(1000); //hold it for a second (1000 milisecconds)

}



