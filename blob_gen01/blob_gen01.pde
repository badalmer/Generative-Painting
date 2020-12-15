// Brandon A. Dalmer  2020
// BLOB GENERATOR

import processing.svg.*;

////////////////CHANGES
int frame = 25; // contain shape size
boolean record = false; // record or not
int points = 25;
///////////////////////

void setup(){
  size(250, 300);
  noLoop();
}

void draw(){
  if(record){
    String fileName = "SSN_"+2020+"shape"+frameCount+".svg";
    beginRecord(SVG, fileName);
    output();
    endRecord();
  }
  else{
    output();
  }
}

void output(){
  background(0);
  fill(255);
  points = (int)random(10, 75);
  beginShape();
  for(int i = 0; i < points; i++){
    curveVertex((int)random(frame, width-frame), (int)random(frame, height-frame));
  }
  endShape();
}

void mousePressed(){
    redraw();
}
