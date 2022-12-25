// Brandon A. Dalmer 2022 - SVG Glitcher 
// load SVG file as XML - format as string 
// find and replace random numbers - save as .svg

import processing.svg.*;
import drop.*;

int numCopy = 5; // number of files I want
int corLevel = 5000; // corruption level
boolean colorRefresh = false;
int colorNum = 5;
///////////////////////
String[] svgText;
String newData;
String[] colorPack;
File myFile;
SDrop drop;
PrintWriter output;

public void setup() {
  size(400, 400);
  background(#0000AA);
  textSize(50);
  textAlign(CENTER);
  fill(#0088FF);
  drop = new SDrop(this);
  text("DRAG 2 BEND", width/2, height/2);
  colorPack = new String[colorNum];
}

public void draw() {
  if(myFile != null) {
    svgText = loadStrings(myFile.toString()); // load file as string
    for(int i = 0; i < colorNum; i++){
      colorPack[i] = Comm64Pick();
     }
    for(int i = 0; i < numCopy; i++) {
      output = createWriter("glitch"+"_"+i+".svg"); // create a document
      for(int j = 0; j < svgText.length; j++) {
        if(j > 30) { // start the bend
          for(int c = 0; c < corLevel; c++) {
            newData = svgText[j].replace(str((int)random(10, 150)), str((int)random(500))); // find and replace
          }
        }
        else{
          recolor(svgText[j]);
        }
        output.println(newData);
      }
    output.flush(); // save as svg/text
    output.close();
    corLevel += 500;
    }
  exit();
  }
}
  
public void recolor(String oldData){
  String[] c = match(oldData, "fill:(.*?);}");  
  if(c != null){
    if(colorRefresh){newData = oldData.replace(c[0], Comm64Pick());}
    else{newData = oldData.replace(c[0], colorPack[(int)random(colorPack.length)]);}
  }
  else{
    newData = oldData;
  }
}
    
public void dropEvent(DropEvent theDropEvent) {
  if(theDropEvent.isFile()) {
    myFile = theDropEvent.file();
  }
}

String Comm64Pick(){
  String[] commodore = {
    "fill:#FFFFFF;}", // white
    "fill:#000000;}", // black
    "fill:#333333;}", // grey 1
    "fill:#777777;}", // grey 2
    "fill:#BBBBBB;}", // grey 3
    "fill:#00CC55;}", // green
    "fill:#AAFF66;}", // light green
    "fill:#0000AA;}", // blue
    "fill:#0088FF;}", // light blue
    "fill:#AAFFEE;}", // cyan
    "fill:#CC44CC;}", // violet
    "fill:#EEEE77;}", // yellow
    "fill:#880000;}", // red
    "fill:#FF7777;}", // light red
    "fill:#DD8855;}", // orange
    "fill:#664400;}"}; // brown
  String pick = commodore[(int)random(commodore.length)];
  return pick;
}
