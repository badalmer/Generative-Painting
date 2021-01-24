// Brandon A. Dalmer 2020 - SVG Glitcher API
// load SVG file as XML - format as string 
// find and replace random numbers - save as .svg

import processing.svg.*;
import drop.*;

int numCopy = 10; // number of copies you want
int corLevel = 1500; // corruption level (max 2000)
///////////////////////

String[] svgText;
String newData;
File myFile;
SDrop drop;
PrintWriter output;

public void setup() {
  size(200, 200);
  background(0, 250, 50);
  textSize(24);
  textAlign(CENTER);
  fill(0);
  drop = new SDrop(this);
  text("DRAG 2 GLITCH", width/2, height/2);
}

public void draw() {
  if(myFile != null) {
    svgText = loadStrings(myFile.toString()); // load file as string
    for(int i = 0; i < numCopy; i++) {
      output = createWriter("glitch"+"_"+i+".svg"); // create a document
      for(int j = 0; j < svgText.length; j++) {
        if(j > 26) { // start the glitch
          for(int c = 0; c < corLevel; c++) {
            newData = svgText[j].replace(str((int)random(10, 150)), str((int)random(500))); // find and replace
          }
        }
        else{newData = svgText[j];}
        output.println(newData);
      }
    output.flush(); // save as svg/text
    output.close();
    }
  exit();
  }
}

public void dropEvent(DropEvent theDropEvent) {
  if(theDropEvent.isFile()) {
    myFile = theDropEvent.file();
  }
}
