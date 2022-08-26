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
    colorPack[c] = simpsonsColor();
  }
}

void draw() {
  // load colors
  if (colorRefresh){
    for(int c = 0; c < colorPack.length; c++){
      colorPack[c] = simpsonsColor(); // pick unique colors
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

int simpsonsColor(){
  color[] simpsons = {
    //color(#FFFFFF), // white
    color(#FFFFFF), // white
    color(#000000), // black
    color(#5da9e3), // sky
    color(#d3d5bd), // clouds
    color(#FED90F), // simpsons yellow
    color(#A2232C), // tongue
    color(#D1B271), // homer facial hair
    color(#4F76DF), // homer pants
    color(#424F46), // homer shoes
    color(#107DC0), // marge hair
    color(#F05E2F), // marge+lisa pearls
    color(#D6E69F), // marge dress
    color(#B4BABD), // burns hair
    color(#F7B686), // burns tie
    color(#007C7A), // burns suit
    color(#6686C7), // bart pants
    color(#60a1a7), // krusty hair
    color(#c8c06f), // pale characters
    color(#ac6494), // krusty shirt
    color(#779c32), // krusty pants
    color(#cf7326), // orange
    color(#d8869d), // simpsons walls
    color(#3b6945), // grass/trees
    color(#559100), // grass/trees 2
    color(#7c3700), // trees
    color(#663143), // trees 2
    color(#d24319), // marge's car
    color(#89488a), // cabnets
    color(#4b58ca), // table cloth
    color(#929522), // fridge
    color(#8c79b0), // kitchen walls
    color(#c43400), // kitchen chairs
    color(#c96939), // kitchen cabnets 2
    color(#709081), // blender
    color(#0e5c5c), // carpet
    color(#6c676e), // kitchen tiles (dark)
    color(#c9c27e)}; // kitchen tiles (light)
  }
  int pick = simpsons[(int)random(simpsons.length)];
  return pick;
}
