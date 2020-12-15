////////////////////////////////////////////////////////
// Brandon A. Dalmer 2019
// composition generator based of assets in DATA folder
// .svg files in DATA folder must contain only paths! Release all compound paths, groups before
////////////////////////////////////////////////////////

import processing.svg.*;   // requires the .svg library
import geomerative.*;      // requires the geomerative library
import processing.serial.*;

Serial myPort;
int val; // data recieved from serial
boolean button = false; // true if using a physical button

////////////////////////////////////////////////////////
/////////////CHANGES////////////////////////////////////
int density = 100; // max 2000 - the larger the number the more complex the result
int numColors = 3; // number of paint layers - max 6
int fileNum = 32; // number of vector files in DATA folder
boolean line = false; // lines? no line? - true or false
float lineWidth = 1; // thickness of line
boolean record = false; // save the output? true or false?
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

PShape[] pshapes = new PShape[fileNum];
RShape[] shapes = new RShape[fileNum];
RPolygon[] poly = new RPolygon[fileNum];
RPoint[] points;

public void setup() {
  RG.init(this);
  
  size(800, 800);        // output size  
  strokeWeight(lineWidth);
  
  for(int i = 0; i < fileNum; i++) {
    pshapes[i] = loadShape(i+".svg");
    shapes[i] = RG.loadShape(i+".svg");
    poly[i] = shapes[i].toPolygon();
  }
}

public void draw(){
  if(button){
    checkButton();
    delay(100);
  }
  //else{Output();} // comment out if you want to stop endless generation
}

public void mousePressed(){
  Output();
}

public void Output(){
  color[] colors = { // random colors
    color((int)random(255), (int)random(255), (int)random(255)),
    color((int)random(255), (int)random(255), (int)random(255)),
    color((int)random(255), (int)random(255), (int)random(255)),
    color((int)random(255), (int)random(255), (int)random(255)),
    color((int)random(255), (int)random(255), (int)random(255)),
    color((int)random(255), (int)random(255), (int)random(255))};
    
    //color((int)random(255)),    // B&W
    //color((int)random(255)),    // B&W
    //color((int)random(255)),    // B&W
    //color((int)random(255)),    // B&W
    //color((int)random(255)),    // B&W
    //color((int)random(255))};   // B&W

  String fileName = "SSN_"+year()+"_"+day()+second()+"BEND"+frameCount+".svg"; // SSN_Year_week-code-version.SVG
  
  ///// Construct /////
  if(record){beginRecord(SVG, fileName);}
  background(colors[(int)random(numColors)]);
  for(int j = 0; j < density; j++) {
    polyGlitch((int)random(fileNum), colors[(int)random(numColors)]);
    //scrambleSVG(pshapes[(int)random(fileNum)], colors[(int)random(numColors)]);
    //Stretch((int)random(fileNum), colors[(int)random(numColors)]);
    //displayChilds(pshapes[(int)random(fileNum)], colors[(int)random(numColors)]);
  }
  Shape((int)random(fileNum), colors[(int)random(numColors)]);
  if(record){
    endRecord();
    save(fileName+".png");
  }
}

public void checkButton(){
  val = myPort.read();  // read it and store it
  if (val == 0) {}
  else {Output();}
  myPort.clear();
}

//////////////////////////////////////////
//////////////////////////////////////////

public void Glitch(int file, int colors){
  RShape s = shapes[file];
  points = s.getPoints();
  int glitch = (int)random(6);
  fill(colors);
  if(!line){noStroke();}
  translate(random(0, width), random(0, height));
  scale(random(6));
  beginShape();
  for(int i = 0; i < points.length; i++) {
    if(glitch == 6){
      vertex(points[i].x += random(1000), points[i].y += random(2000));
    }
    else{
      vertex(points[i].x, points[i].y);
    }
  }
  endShape();

}

//////////////////////////////////////////
//////////////////////////////////////////

public void polyGlitch(int file, int colors){
  RPolygon p = poly[file];
  points = p.getPoints();
  int glitch;
  int xloc = (int)random(-100, width-200);
  int yloc = (int)random(-100, height-200);
  fill(colors);
  if(!line){noStroke();}
  beginShape();
  for(int i = 0; i < points.length; i++) {
    glitch = (int)random(100);
    if(glitch == 6 || glitch == 66){
      vertex(points[i].x + xloc+glitch*10, points[i].y + yloc+glitch); // pull random vertex
    }
    else{ vertex(points[i].x + xloc, points[i].y + yloc); } // do nothing
  }
  endShape();
  rotate(.5);
}

//////////////////////////////////////////
//////////////////////////////////////////

public void Stretch(int file, int colors){
  if(!line){noStroke();}
  shapes[file].setFill(colors);
  RG.shape(shapes[file], random(-200, width), random(-200, height), density*2, (int)random(density)/4);
}

//////////////////////////////////////////
//////////////////////////////////////////

public void Shape(int file, int colors){
  if(!line){noStroke();}
  rotate(random(45));
  shapes[file].setFill(colors);
  RG.shape(shapes[file], 0, 0, random(width), random(height));
}

//////////////////////////////////////////
//////////////////////////////////////////

public void displayChilds(PShape file, int colors) {
  PShape ps;
  file.disableStyle();
  file.rotate(random(90));
  if(!line) {noStroke();};
  for(int i = 1; i < file.getChildCount(); i++) {
    ps = file.getChild(i);
    fill(colors);
    shape(ps, random(-200, width+200), random(-200, height+200));
  }
}

//////////////////////////////////////////
//////////////////////////////////////////

public void scrambleSVG(PShape file, int colors) {
  PShape ps;
  file.disableStyle();
  if(!line) { noStroke(); }
  fill(colors);
  for(int i = 1; i < file.getChildCount(); i++) {
    ps = file.getChild(i); // add shape
    for(int v = 0; v < ps.getVertexCount(); v = v+(int)random(density)) {
      PVector pv = ps.getVertex(v);
      pv.x = (int)random(-100, width+100);
      pv.y = (int)random(-100, height+100);
      ps.setVertex(v, pv);
    }
    shape(ps, random(-200, width+200), random(-200, height+200));
  }
}
    
    
