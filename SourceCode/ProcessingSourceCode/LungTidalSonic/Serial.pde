String arduinoUSB = "/dev/tty.usbserial-A7006Tac";
//String arduinoUSB = "/dev/tty.usbmodem1411";
int myArd;
float sonicV;
float sonicVraw;
float sonicVrawPrev = Float.NaN;
float sonicVrawMaxDelta = 180.0;
float sonicVrawDelta = Float.NaN;
float MAX_DISTANCE_PRAC = 400;
// Sensor readings above this value are ignored so that jitter at the 
// down position does not read as data.
float zeroCutOff = 380;  


void setupSerial(){
  println("Available serial ports:");
  println((Object[])Serial.list());
  // Use the port corresponding to your Arduino board.  The last
  // parameter (e.g. 19200) is the speed of the communication.  It
  // has to correspond to the value passed to Serial.begin() in your
  // Arduino sketch.
  println("Looking for " +arduinoUSB);
  myArd = check4SerialDevice(arduinoUSB);
  //println(myArd + " check4");
  if (myArd != -1){
    println("Found " +arduinoUSB + " at " +myArd);
    port = new Serial(this, Serial.list()[myArd], 19200);
    port.bufferUntil(MARKER);
  }
  else{
    println("Did not find Arduino USB driver " + arduinoUSB);
  }
}

void serialEvent(Serial port) { 
  dataStr = (port.readStringUntil(MARKER));
  if (dataStr.length() >=2){
    dataStr = dataStr.substring(0, dataStr.length()-1); // strip off the last  char
    sonicVraw = float(dataStr);
    
    // detect and ignore zinger values
    if (sonicVraw < MAX_DISTANCE_PRAC){
          sonicVrawDelta = sonicVraw - sonicVrawPrev;
          // println(sonicVraw + " <= now | prev => " + sonicVrawPrev );
          if ( sonicVrawDelta > sonicVrawMaxDelta){
            // println(sonicVrawDelta + " Ingorning " + sonicVraw );
            return;
          }
          // println(sonicVrawDelta + " is current delta");
    } else {
      // println("Spurious serial data. " + sonicVraw  );
      return;
    }
    sonicVrawPrev = sonicVraw;
    if (myCal != -1){  // normal condition
        sonicV = calibrationTable.getCalValue(sonicVraw);
        if (sonicVraw > zeroCutOff){
          sonicV = 0;
        }
    } 
    else { // abnormal, calibration table not found
        sonicV = map(sonicVraw,spiroMinData,spiroMaxData,0,6); 
        sonicV = max(0,sonicV);
        if (sonicVraw > zeroCutOff){
          sonicV = 0;
        }
    }
    
    if ((dataStr != null) & (curTest < qtyTests)) { // ie stop after last test
      arysonicV[curTest] = sonicV;
      if(arysonicV[curTest] > arysonicMax[curTest]){
        arysonicMax[curTest] = arysonicV[curTest];
      }
    }
  }
}

int check4SerialDevice(String devName){
  String[] devList;
  devList = Serial.list();
  for (int i= 0; i < devList.length;i++){
    String devN = devList[i];
    if (devN.equals(devName) == true){
      return i;
    }    
  }
  return -1;
}
