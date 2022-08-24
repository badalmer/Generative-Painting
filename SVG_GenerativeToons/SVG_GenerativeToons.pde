import processing.svg.*;

/////////
// Brandon A. Dalmer 2022
// Manipulate and Compose compositions from a database of vectors
/////////

////////////CHANGES
float lineWidth = 0;
int fileNum = 25;
int density = 100;
PShape[] toonDatabase = new PShape[fileNum];
color[] colorPack = new int [4]; // number of colors max 8
boolean groupLayers = false;
boolean fill = true;
boolean svgOut = false;
boolean pngOut = false;
boolean colorRefresh = false;
int ammountRun = 10;
///////////////////


void setup() {
  size(900, 900);
  background(255);
  noLoop();
  
  // load samples
  for(int i = 0; i < fileNum; i++){
    toonDatabase[i] = loadShape(i+".svg");
  }
  for(int c = 0; c < colorPack.length; c++){
    colorPack[c] = Comm64Pick();
  }
}

void draw() {
  // load colors
  if (colorRefresh){
    for(int c = 0; c < colorPack.length; c++){
      colorPack[c] = Comm64Pick(); // pick unique colors
    }
  }
  String fileName = "SSN_"+year()+"_"+day()+second()+"TOON";
  if(svgOut){beginRecord(SVG, fileName+".svg");}
  background(colorPack[(int)random(colorPack.length)]);
  for(int i = 0; i < density; i++){
    toonDraw(colorPack[(int)random(colorPack.length)]);
    displayChilds(colorPack[(int)random(colorPack.length)]);
  }
  if(svgOut){endRecord();}
  if(pngOut){save(fileName+".png");}
  
  //draw swatch
  fill(255);
  rect(width-50, 0, 50, height);
  int Y = height-50;
  for(int i = 0; i < colorPack.length; i++){
    fill(colorPack[i]);
    square(width-50, Y, 50);
    Y = Y-50;
  }
}

void mousePressed(){
  redraw();
}

void toonDraw(int fillColor){
  if(lineWidth <= 0){noStroke();}
  else{strokeWeight(lineWidth);}
  
  // draw layers
  int file = (int)random(toonDatabase.length);
  toonDatabase[file].disableStyle();  
  if(fill){fill(fillColor);}
  else{fill(255);}
  //toonDatabase[file].rotate(random(90));
  shape(toonDatabase[file], width/2, height/2, random(width, 1000), random(height, 1000));
}

void displayChilds(int fillColor){
  PShape ps;
  PShape file = toonDatabase[(int)random(fileNum)];
  file.disableStyle();
  if(lineWidth > 0){strokeWeight(lineWidth);}
  else{noStroke();}
  file.rotate(random(90));
  for(int i = 1; i < file.getChildCount(); i++){
    ps = file.getChild(i);
    fill(fillColor);
    shape(ps, random(-200, width+1000), random(-20, height+1000)); 
  }
}

void keyPressed(){
  if(key == 'r' || key == 'R'){ // refresh color
    colorRefresh = true;
  }
  if(key == 'h' || key == 'H'){ // hold color
    colorRefresh = false;
  }
}

int Comm64Pick(){
  color[] commodore = {
    color(#FFFFFF), // white
    color(#000000), // black
    color(#333333), // grey 1
    color(#777777), // grey 2
    color(#BBBBBB), // grey 3
    color(#FFFFFF), // white
    color(#00CC55), // green
    color(#AAFF66), // light green
    color(#0000AA), // blue
    color(#0088FF), // light blue
    color(#AAFFEE), // cyan
    color(#CC44CC), // violet
    color(#EEEE77), // yellow
    color(#880000), // red
    color(#FF7777), // light red
    color(#DD8855), // orange
    color(#664400)}; // brown
  int pick = commodore[(int)random(commodore.length)];
  //subset(commodore, pick);
  return pick;
}
