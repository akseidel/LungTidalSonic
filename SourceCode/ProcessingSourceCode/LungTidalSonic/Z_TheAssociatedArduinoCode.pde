    ///*
    //  The Arduino side for the processing LungTidal. This version uses
    //  the HC-SR04 sonic distance sensor along with with the DHT11 Temp
    //  and Humidity sensor for correction. Revised 5/2018 from the original
    //  LungTidal that read a potentiometer.
    
    //  Arduino code to send HC-SR04 distance reads out to the LungTidal
    //  processing program
     
    //  You can use the Arduino serial monitor to view the sent data, or it can
    //  be read by Processing. 
      
    //  The LungTidal Processing code (sonic version) graphs the data received
    //  so you can see the value of the sonic distance reads changing over time.
    //*/
    //// DHT Libraries from Adafruit
    //// Dependant upon Adafruit_Sensors Library
    //#include "DHT.h";
    //// NewPing Library for HC-SR04
    //#include "NewPing.h"
    
    //// Constants
    //#define DHTPIN 7                  // DHT-11 Output pin number
    //#define DHTTYPE DHT11             // DHT Type is DHT 11
    //#define TRIGGER_PIN  12           // DHT trigger pin number
    //#define ECHO_PIN     11           // DHT echo pin number
    
    //#define RDLEDPIN 13               // LED connected to digital pin 13, distance reading
    //#define DHTRDLEDPIN 8               // LED connected to digital pin 8, dht read
    
    //// distance units will be mm in this sketch so that the integer
    //// value can be sent with enough resolution
    //#define MAX_DISTANCE 440          // Sent to sensor library, reports 0 beyond this
    //#define MAX_DISTANCE_PRAC 400     // Practical distance in distance units
    //#define MIN_DISTANCE 2            // Practical minimum distance in distance units
    //#define SAMPLE_DELAY 80           // Main loop sample delay
    //#define SENSOR_INVERVAL_FACTOR 16 // Any loop counter multiple of this triggers temp/hum read.
    //#define ITERATIONS 5              // Number of reads per averaging
    
    //// Note: SAMPLE_DELAY * SENSOR_INVERVAL_FACTOR = time between temp/hum checks.
    //// This needs to be at least 500 ms. Reported to be 2000 ms required. 
    //// This time interval allows the DHT-11 sensor can stabilize.
    
    //// Define Variables
    
    ////int value = LOW;      // Previous value of the LED
    //int readValue = 0;    // Variable to hold the read value
    //int lastValue = 0;    // Previous readValue
    //int readDelta = 2;    // Read threshold difference for reporting
    //float hum = 55;       // Humidity value in percent, default in case of dht error
    //float temp = 23;      // Temperature value in Celsius, default in case of dht error
    //float duration;       // HC-SR04 pulse read duration value
    //float distance;       // Calculated distance in cm
    //int counter = 0;      // Cycle counter
    
    //// Initialize sensors
    //NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
    //DHT dht(DHTPIN, DHTTYPE);
    
    //void setup() {
    //  Serial.begin(19200);
    //  pinMode(RDLEDPIN, OUTPUT);      // sets the digital pin as output
    //  dht.begin();
    //  GetTempHum();
    // // Serial.println("");           // for debuging
    // // Serial.println("Starting");   // for debuging
    //}
    
    //void loop() {
      
    //  counter ++;
    //  if (counter % SENSOR_INVERVAL_FACTOR == 0){
    //    GetTempHum();
    //    // Serial.println("Temp/Hum Just Read " ); // for debuging
    //    // Serial.println( hum); // for debuging
    //    // Serial.println( temp); // for debuging
    //    counter = 0;
    //    blinkLed();
    //  }
     
    //  // read vlaue on distance sensor
    //  // but return smaller of the reading or MAX_DISTANCE_PRAC
    //  readValue = fmin(distread(),MAX_DISTANCE_PRAC);
    //  // if dist has changed more than delta
    //  if (abs(readValue-lastValue) > readDelta) {
    //    Serial.print(readValue);
    //    Serial.print("A");
    //    lastValue = readValue;
    //    digitalWrite(RDLEDPIN, HIGH);
    //  }
          
    //  delay(SAMPLE_DELAY);
    //  digitalWrite(RDLEDPIN, LOW);
    //}
    
    //int distread(){
    //  float soundsp;  // Stores calculated speed of sound in M/S
    //  float soundmm;  // Stores calculated speed of sound in mm/ms
    //  // Calculate the Speed of Sound in M/S
    //  soundsp = 331.4 + (0.606 * temp) + (0.0124 * hum);
    //  // Convert to mm/ms
    //  soundmm = soundsp / 1000;
    //  duration = sonar.ping_median(ITERATIONS);
    //  // Calculate the distance in mm as integer
    //  return (int)(duration / 2) * soundmm;
    //}
    
    //void GetTempHum(){
    //   hum = dht.readHumidity();  // Get Humidity value
    //   temp= dht.readTemperature();  // Get Temperature value
    //   if (isnan(hum)) {
    //    hum = 40;
    //   }
    //   if (isnan(temp)) {
    //    temp = 23;
    //   }
       
    //}
    
    //void blinkLed(){
    //  digitalWrite(DHTRDLEDPIN, HIGH);
    //  delay(SAMPLE_DELAY);
    //  digitalWrite(DHTRDLEDPIN, LOW);
    //}
