
void keyPressed() {
  if (mouseOnMyName()){
    if ((keyCode >=32) && (keyCode <= 126)) {
      myName = myName + key;
    } 
    else {
      if (keyCode == 8){
        if (myName.length()>0){
          myName = myName.substring(0, myName.length()-1); // strip off the last  char    
        }
      }
    }
  }
}
