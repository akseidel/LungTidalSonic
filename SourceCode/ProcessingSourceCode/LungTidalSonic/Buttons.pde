
void setupButtons(){
  butQuit = new PushButton("Quit",30,60,butQuitLeft,butQuitTop,150,200); 
  butRestart = new PushButton("Restart",30,60,butRestartLeft,butRestartTop,150,200);
  butPrint = new PushButton("Print",30,60,butPrintLeft,butPrintTop,150,200);

}

void drawButtons(){
  butQuit.display();
  butRestart.display();
  if (curTest >= qtyTests){ // curTest will reach qtyTest
    butPrint.display();
  } 
}

/*
/ This class creates a button and handle the mouseover chanhe in look. It was not possible
 / to put the mousepressed within this class. It sort of worked but was slow and the mousepressed
 / event seemed to stay activated.
 */

class PushButton {
  String caption;
  int butHt ;
  int butWd ;
  int butLeft;
  int butTop  ;
  int fcR;
  int fcP;
  PushButton(String _caption, int _butHt, int _butWd, int _butLeft, int _butTop, int _fcR, int _fcP){
    caption = _caption;
    butHt = _butHt;
    butWd = _butWd;
    butLeft = _butLeft;
    butTop = _butTop;
    fcR = _fcR;
    fcP = _fcP;
  }
  void display(){
    if (mouseOver()){
      fill(fcR+50);
      stroke(0, 255, 0);
    }
    else{
      fill(fcR);
      stroke(0,0,255);  
    }
    rectMode(CORNERS);
    rect(butLeft,butTop,butLeft+butWd,butTop + butHt);
    fill(0);
    textFont(plotFont);
    textSize(10);
    textAlign(CENTER,CENTER);
    text(caption, butLeft + butWd/2, butTop + butHt/2);
  }  
  boolean mouseOver(){
    if((mouseX > butLeft) & (mouseX < (butLeft+butWd))){
      if ((mouseY < (butTop+butHt)) & (mouseY > butTop)){
        return true;
      } 
      else{
        return false;
      }
    }
    else{
      return false;
    }
  }
}

// This assumes all the buttons are at the same X
void mousePressed(){
  if((mouseX > butQuitLeft) & (mouseX < (butQuitLeft+60))){
    if ((mouseY < (butQuitTop+30)) & (mouseY > butQuitTop)){
      //mm.finish();
      quitProgram();
    }
    if ((mouseY < (butRestartTop+30)) & (mouseY > butRestartTop)){
      resetTesting();
    }
    if (curTest >= qtyTests){
      if ((mouseY < (butPrintTop+30)) & (mouseY > butPrintTop)){
        printTrials();
      }
    }  
  }
}

void quitProgram(){
  exit();
}

void resetTesting(){
  sonicVrawPrev = Float.NaN;
  if (myArd != -1){
    text("Inializing and Restarting Trials",plotX1+ 20,plotY1 + 40);
    port.stop();
    for (int i = 0; i < qtyTests; i ++){
      arysonicV[i] = 0;
      arysonicMax[i] = 0;
    }
    curTest = 0;
    setupSerial();
  } 
  else{
    exit();
  }
}
