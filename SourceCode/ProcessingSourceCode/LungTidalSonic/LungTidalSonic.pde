
/*
/ LungTidalSonic 4/2018, original LungTidal 4/2009
/ A program for graphing lung tidal data collected by an Arduino PIC connected to a sonic distance
/ sensor mounted to a spirometer. The Arduino places the data on the serial port for LungTidalSonic to see.
*/
import processing.serial.*;
import processing.pdf.*;

//MovieMaker mm;  // Declare MovieMaker object

Serial port;
String dataStr;  // input string from serial port
String myName;
int MARKER = 65; // the letter A used to decode the serial input sent by the Arduino
boolean printScrn;
float dataMin, dataMax;
float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
float colP, colW;

float[] arysonicV, arysonicMax; 
float tRng;
float litersPerDataVal;
float plotVertRange;
float spiroMinData;
float spiroMaxData;

int curTest; // the current trial
int qtyTests = 3; // number of automatic trials
float volumeInterval = 1.0; // used for graph
float volumeIntervalMinor = 0.1; //used for graph
float volAtLeastThis = 0.5; // current trail max value must exceed this before moving tonext trial

int breathColor = #5AA4D2;
int completedColor = #0106FC;
int spuriousColor = #FF0000;

PFont plotFont;

int butQuitLeft;
int butQuitTop;
int butRestartLeft;
int butRestartTop;
int butZeroLeft;
int butZeroTop;
int butPrintLeft;
int butPrintTop;
PushButton butQuit;
PushButton butRestart;
PushButton butZero;
PushButton butPrint;

CalTable calibrationTable; // calibration text file is in the Data folder
   
void setup(){
  size(720,605);
  // Create MovieMaker object with size, filename,
  // compression codec and quality, framerate
  // mm = new MovieMaker(this, width, height, "LungTidal.mov",
  //                      56, MovieMaker.ANIMATION, MovieMaker.BEST);
  myName = "Your Name Here";
  calibrationTable = new CalTable("calibration_data.tsv");  
  dataStr = "0";
  dataMin = 0;
  dataMax = 1023;
  plotVertRange = 6;
  float litersAtDataMax = 6.0;
  spiroMinData = 390;
  spiroMaxData = 82;
  litersPerDataVal = litersAtDataMax/dataMax;
  plotX1 = 120;
  plotX2 = width - 80;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height -70;
  labelY = height - 25;

  plotFont = createFont("SansSerif",20);
  textFont(plotFont);
  colP = 0.15;
  colW = colP*(plotX2-plotX1);
  curTest = 0;
  arysonicV = new float[qtyTests];
  arysonicV[0] = 0;
  arysonicV[1] = 0;
  arysonicV[2] = 0;
  arysonicMax = new float[qtyTests];
  arysonicMax[0] = 0;
  arysonicMax[1] = 0;
  arysonicMax[2] = 0;
  sonicV = 0;
  tRng = qtyTests*2;
  smooth();
  setupSerial();

  butQuitLeft = int(plotX2)+8;
  butQuitTop = int(plotY1)-50;
  butRestartLeft = int(plotX2)+8;
  butRestartTop = int(plotY1);
  butZeroLeft = int(plotX2)+8;
  butZeroTop = int(plotY1)+35;
  butPrintLeft = int(plotX2)+8;
  butPrintTop = int(plotY1)+70;
  setupButtons();
  //PrintIt p = new PrintIt();
  
}

void draw(){
  background(224);
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1,plotY1,plotX2,plotY2);
  drawTitle();
  drawAxisLabels();
  drawVolumeLabels();
  drawButtons();
  if (myArd != -1){
    drawDataArea();
    drawMaxDataLine();
    calcStatusValues();
    incrementTest();  
    }else{
    drawNoArduino();  
  }
}
 

void calcStatusValues(){
  float avgOfTests,maxOfTests,minOfTests;
  maxOfTests = 0;
  minOfTests = MAX_INT;
  avgOfTests = 0;
  for (int i = 0; i <= min(curTest,(qtyTests-1)); i ++){
    maxOfTests = max(arysonicMax[i],maxOfTests);
    minOfTests = min(arysonicMax[i],minOfTests);
    avgOfTests = (arysonicMax[i]+avgOfTests);
  }
  avgOfTests = avgOfTests/(min(curTest,(qtyTests-1))+1); 
  drawStatusValues(maxOfTests, minOfTests, avgOfTests);
}

void incrementTest(){
  if (curTest < qtyTests){ // curTest will reach qtyTest
   if ((arysonicV[curTest]==dataMin) & (arysonicMax[curTest]> (volAtLeastThis+ arysonicV[curTest]))){
     curTest++;
   } 
  }
}

void drawDataArea(){
  for (int colm = 0; colm <= curTest; colm ++){
    if ((colm == curTest) &(curTest < qtyTests)){ // an ongoing trial
      fill(breathColor);
      beginShape();
      float x = map((colP+colm),0,tRng,plotX1,plotX2);
      float y = map(arysonicV[colm],plotVertRange,0,plotY1,plotY2);
      float yy = min(y,plotY2);
      vertex(x,yy);
      vertex(x+colW,yy);
      vertex(x+colW,plotY2);
      vertex(x,plotY2);
      endShape(CLOSE);
      if(arysonicV[colm] <= arysonicMax[colm]-(30*litersPerDataVal)){
        textSize(10);
        textAlign(CENTER);
        text(nfc(arysonicV[colm],2),x+colW/2,yy-3);
      }
    }else{ // a finished trial
      fill(completedColor);
      if (colm < qtyTests){
        beginShape();
        float x = map((colP+colm),0,tRng,plotX1,plotX2);
        float y = map(arysonicMax[colm],plotVertRange,0,plotY1,plotY2);
        float yy = min(y,plotY2);
        vertex(x,yy);
        vertex(x+colW,yy);
        vertex(x+colW,plotY2);
        vertex(x,plotY2);
        endShape(CLOSE);
      }
    }
  }
}

void drawMaxDataLine(){
  textSize(15);
  stroke(0);
  for (int colm = 0; colm <= curTest; colm ++){
    if (colm < qtyTests){
      float x = map((colP+colm),0,tRng,plotX1,plotX2);
      float y = map(arysonicMax[colm],plotVertRange,0,plotY1,plotY2);
      float yy = y ; //max(y,0);
      fill(0);
      textAlign(CENTER); 
      text(nfc(arysonicMax[colm],2),x+colW/2,yy-5);
      fill(#0200CB);
      if (colm == curTest ){
        strokeWeight(2);
      } else{
        strokeWeight(1);  
      }
      line(x,yy,x+colW,yy);// draw max line
      line(x,plotY2,x,yy);
      line(x+colW,plotY2,x+colW,yy);
      fill(0);
      text("Trial "+ (colm+1),x+colW/2,plotY2+25);
    }  
  }
}
