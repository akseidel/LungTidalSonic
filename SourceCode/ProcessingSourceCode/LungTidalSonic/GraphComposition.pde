
void drawTitle(){
  fill(0);
  textFont(plotFont);
  textSize(20);
  textAlign(LEFT);
  String title = "Lung Tidal Volume";
  if (curTest < qtyTests){
    title = title + " - Starting Trial " + str(curTest+1) + " of " + str(qtyTests);
  }else{
    title = title + " - Finished";
  }
  text(title,plotX1,plotY1 - 25);
}

void drawAxisLabels(){
  fill(0);
  textFont(plotFont);
  textSize(13);
  textLeading(15);
  textAlign(CENTER,CENTER);
  text("Spirometer\nVolume\nIn\nLiters",labelX,(plotY1+plotY2)/2);
}

void drawVolumeLabels(){
  fill(0);
  textFont(plotFont);
  textSize(10);
  stroke(128);
  strokeWeight(1);
  float magnify = 10;  // required due to a problem with the modulo function
  for (float v = dataMin; v <=plotVertRange*magnify; v+= volumeIntervalMinor*magnify){
    float y =map(v,dataMin,plotVertRange,plotY2,plotY1);
    if (v % volumeInterval ==0) { // if a major tick
      if(v==dataMin){
        textAlign(RIGHT); //align by the bottom
      }
      else if(v==dataMax){
        textAlign(RIGHT,TOP); //align by the top
      }
      else{
        textAlign(RIGHT,CENTER);//center vertically
      }
      text(nfc(v,1),plotX1-10,y);
      stroke(0);
      line(plotX1-4,y,plotX1,y);// draw major tick
      stroke(192);
      line(plotX1,y,plotX2,y);// draw major line
      stroke(128);
    }
    else{
      line(plotX1-2,y,plotX1,y);
    }
  }
}

void drawStatusValues(float maxOfTests, float minOfTests, float avgOfTests){
  fill(0);
  textFont(plotFont);
  textSize(20);
  textAlign(RIGHT,BASELINE);
  String maxT = nfc(maxOfTests,2);
  String minT = nfc(minOfTests,2);
  String avgT = nfc(avgOfTests,2);
  String curP = nfc(sonicV,2);
  if (mouseOnMyName()) {
    fill(255,0,0);
  }else{
    fill(0);
  }
  
  text(myName, plotX2-5, plotY1+25);
  fill(0);
  text("Maximum: "+  maxT + " L", plotX2-5, plotY1+50);
  text("Minimum: "+  minT + " L", plotX2-5, plotY1+75);
  text("Average: "+ avgT + " L", plotX2-5, plotY1+100);
  
  textFont(plotFont);
  textSize(15);
  textLeading(18);
  text(timeStamp(),plotX2-5,plotY1+125);
  
  textAlign(RIGHT,BASELINE);
  text("Spirometer Reading: "+ curP, plotX2, plotY2+25);
  text("Raw Reading: "+ dataStr, plotX2, plotY2+40);
  if (dataStr ==null){
    drawNeedToReset();
  }
  if (myCal == -1){
    drawNoCalibrationTable();
  }
}

boolean mouseOnMyName(){
 if((mouseX >plotX2-200) & (mouseX < plotX2-5)){
    if ((mouseY < ( plotY1+25)) & (mouseY >  plotY1)){
      return true;
    }else{
      return false;
    }
 }else{
   return false;
 }
}


String timeStamp(){
  String amPm;
  String d = String.valueOf(day());    // Values from 1 - 31
  String m = String.valueOf(month());  // Values from 1 - 12
  String y = String.valueOf(year());   // 2003, 2004, 2005, etc.
  int hr = hour();
  String h;
  if (hr > 12){
    h = String.valueOf(hour()-12);
    amPm = "pm";
  }else{
    h = String.valueOf(hour());
    amPm = "am";
  }
  String mn = String.valueOf(minute());
  String s = String.valueOf(second());
  return h+":"+mn+":"+s + " " + amPm + "\n" +m+"/"+d+"/"+y;
}

void drawNoArduino(){
  fill(#FF0004);
  textFont(plotFont);
  textSize(20);
  textLeading(28);
  textAlign(LEFT,BASELINE);
  String msg = arduinoUSB + "\nUSB driver NOT detected.\n\nEither the Arduino device is not connected\nor the device driver is not loaded.";
  msg = msg + "\nClose this program.  Fix the problem.\nRestart the program.";
  msg = msg + "\n";
  msg = msg + "\nUSB drivers that were detected:";
  String[] devList;
  devList = Serial.list();
  for (int i= 0; i < devList.length;i++){
    String devN = devList[i];
    msg = msg + "\n" + devN;  
  }
  text(msg, width*7/24-40,height/2-200);
}

void drawNeedToReset(){
  fill(#FF0004);
  textFont(plotFont);
  textSize(24);
  textLeading(28);
  textAlign(LEFT,BASELINE);
  String msg = "Reset the spirometer to the bottom.\n\nPress the Restart button.\n\nWait until there is a non-null raw reading.";
  text(msg, width*0.2,height/2-40);
}


void drawNoCalibrationTable(){
  fill(#FF0004);
  textFont(plotFont);
  textSize(15);
  textLeading(18);
  textAlign(LEFT,BASELINE);
  String msg = "The calibration table seems to be missing. It belongs\nin a folder named \"Data\" one level deeper than this\napplicaton.";
  msg = msg + "\n\nThe calibration table contains pairs of dial readings and\ncorresponding raw data values at every 0.5 L increments";
  msg = msg + "\nin Tab separated, plain text file format. This program\nuses that file to interpolate raw data values between";
  msg = msg + "\nthe pairs intervals. The spirometer readings displayed\nbelow are not calibrated.\n"; 
  msg = msg + "\nRecord the spirometer dial readings and corresponding\ndisplayed raw readings. Create the calibration file\nand then restart the program.";
  text(msg, width*15/48-10,height/2-60);
}
