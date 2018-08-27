
void printTrials(){
    println("printing");
    String myDir = whereAmI();
    println(myDir);
    String myPDFJob =  myDir +"/LungTidalPrintJob.pdf";
    println(myPDFJob);
    beginRecord(PDF, myPDFJob); 
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
    }
    else{
      drawNoArduino();  
    }
    endRecord();
    try{
      Runtime.getRuntime().exec("open -a Preview " + myPDFJob);
    } 
    catch (IOException e){
      e.printStackTrace();
    }
  }

String whereAmI(){
  String myExecPath;
  myExecPath = System.getProperty("user.dir");
  String myPath = myExecPath.replace("\\", "/");
  return myPath;
}
