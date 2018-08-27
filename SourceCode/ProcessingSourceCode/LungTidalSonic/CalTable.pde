int myCal;

class CalTable {
  float[][] data;  
  int rowCount;

  CalTable() {
    data = new float[10][10];
  }

  CalTable(String filename) {
    println("Reading calibration table " + filename);
    String[] rows = loadStrings(filename);
    if (rows != null){
      data = new float[rows.length][];
      for (int i = 0; i < rows.length; i++) {
        if (trim(rows[i]).length() == 0) {
          continue; // skip empty rows
        }
        println(rows[i]);
        if (rows[i].startsWith("#")) {
          continue;  // skip comment lines
        }
        // split the row on the tabs
        float[] pieces = float(split(rows[i], TAB));
        // copy to the table array
        data[rowCount] = pieces;
        rowCount++;
        // this could be done in one fell swoop via:
        //data[rowCount++] = split(rows[i], TAB);
      }
      // array is one row too large, resize the 'data' array as necessary
      rowCount--;
      data = (float[][]) subset(data, 0, rowCount);
      println("Read " + rowCount + " rows of calibration pairs.");
    } 
    else {
      myCal = -1;
      println("... Calibration table " +filename + " is not found!");
    }
  }
  
  
  int getRowCount() {
    return rowCount;
  }

  // return calibrated value
  // 5/2018 modified from 2009 version to project beyond the 
  // maximum calibration value and account for raw sonic data
  // being reversed.
  float getCalValue(Float sensorVal) {
    float interP = 0; //<>//
    
    // handle outlying sensorVal first.
    // sensorVal is larger than the largest (smallest volume)
    if (sensorVal >= data[0][1]){ //<>//
      return data[0][0];
    } 
    
    // sensorVal is smaller than the smallest (largest volume)
    if (sensorVal <= data[rowCount-1][1]) { //<>//
      float delta = data[rowCount-2][1]-data[rowCount-1][1];
      float amt = (data[rowCount-1][1]-sensorVal)/delta;
      interP = lerp(data[rowCount-2][0],data[rowCount-1][0],amt);
      return interP;
    }

    // At this point sensorVal is within the table
    for (int i = rowCount -1; i > -1; i--) { //<>//
      if( data[i][1] > sensorVal) {
        float delta = data[i][1]-data[i+1][1];
        float amt = (data[i][1]-sensorVal)/delta;
        interP = lerp(data[i][0],data[i+1][0],amt);
        break;
      }   
    }
    return interP;
  }
  
  //float getFloat(int rowIndex, int column) {
  //  return data[rowIndex][column];
  //}
  
}
