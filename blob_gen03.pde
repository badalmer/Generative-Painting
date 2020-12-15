// Brandon A. Dalmer 2020
// Perlin Noise Blob Generator
import processing.svg.*;

////// CHANGES
float noiseMax = 0.8;
float complexity = .03;
//boolean record = true; // record or not
boolean record = false; // record or not
int numCopy = 10;
//////////////

void setup(){
  size(600, 600);
  noLoop();
}

void draw(){
  if(record) {
    for(int i = 0; i < numCopy; i++) {
      beginRecord(SVG, "blob_"+i+".svg");
      output();
      endRecord();
    }
    exit();
  }
  else{
    output();
  }
}

void output(){
  background(0);
  translate(width/2, height/2);
  fill(255);
  beginShape();
  for(float a = 0; a < TWO_PI; a+=complexity){
    float xoff = map(cos(a), -1, 1, 0, noiseMax);
    float yoff = map(sin(a), -1, 1, 0, noiseMax);
    float r = map(noise(xoff, yoff), 0, 1, 100, 200);
    float x = r * cos(a);
    float y = r * sin(a);
    vertex(x, y);
  }
  endShape(CLOSE);
  noiseMax += noise(complexity);
}

void mousePressed(){
  redraw();
}
