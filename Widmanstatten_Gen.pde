// Brandon A. Dalmer 2019
// Widmanstätten Pattern Generator

import geomerative.*;
import processing.svg.*;

//////////////changes////////
int density = 200; // time - 1 degree cooling/ 1000 years
int max_thickness = 15; // 
int wobble = 8; // 
int numColors = 3; // 
/////////////////////////////

color[] colors = {  // random b/w tones
color((int)random(255)),
color((int)random(255)),
color((int)random(255)),
color((int)random(255)),
color((int)random(255)),
color((int)random(255))};

boolean record = true;
int numFiles = 3;

void setup() {
  size(1296, 1728); 
  noLoop();
  noSmooth();
  background(colors[(int)random(numColors)]);

  RG.init(this);
  RCommand.setSegmentLength(25);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
}

void draw(){
  for(int n = 0; n < numFiles; n++){
    if(record){beginRecord(SVG, "widmanstatten-"+n+".svg");}
      background(colors[(int)random(numColors)]);
    for(int f = 0; f<density; f++){
      strokeWeight(random(max_thickness));
      stroke(colors[(int)random(numColors)]);
      RShape line = RShape.createLine(random(-100, width+100), random(-100, height+100), random(-100, width+100), random(-100, height+100));
      RPolygon lineOutline = line.toPolygon();    
      for(int i = 0; i < lineOutline.contours[0].points.length; i++){
        RPoint curPoint = lineOutline.contours[0].points[i];
        curPoint.x += random(-wobble, wobble);
        curPoint.y += random(-wobble, wobble);  
      }
    lineOutline.draw(); 
    }
    if(record){
      endRecord();
    }
  }
  exit();
}
