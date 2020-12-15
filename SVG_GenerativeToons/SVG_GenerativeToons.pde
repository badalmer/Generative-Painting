import processing.svg.*;

/////////
// Brandon A. Dalmer 2020
// Layer Seperation - compile a layer of multiple shapes (same color) -> Layer
/////////

////////////CHANGES
float lineWidth = 0;
int fileNum = 25;
int density = 100;
PShape[] toonDatabase = new PShape[fileNum];
color[] colorPack = new int [6]; // number of colors max 8
boolean colorRefresh = true;
boolean fill = true;
boolean record = false;
int ammountRun = 1;
///////////////////

void setup() {
  size(770, 720);
  background(255);
  noLoop();
  
  // load samples
  for(int i = 0; i < fileNum; i++){
    toonDatabase[i] = loadShape(i+".svg");
  }
  
  if(!colorRefresh){ // make colors not change
    for(int c = 0; c < colorPack.length; c++){
      colorPack[c] = colors();
    }
    // check for doubles??
  }
}

void draw() {
  if(colorRefresh){ // new colors on redraw
    for(int c = 0; c < colorPack.length; c++){
      colorPack[c] = colors();
    }
  }
  
  if(record){
    for(int i = 0; i < ammountRun; i++){
      beginRecord(SVG, "toon"+i+".svg");
      background(colorPack[(int)random(colorPack.length)]);
      toonDraw();
      endRecord();
    }
    exit();
  }
  else{
    background(colorPack[(int)random(colorPack.length)]);
    toonDraw();
  }
}

void mousePressed(){
  redraw();
}

void toonDraw(){
  if(lineWidth <= 0){noStroke();}
  else{strokeWeight(lineWidth);}
  
  // draw layers
  for(int l = 0; l < colorPack.length; l++){
    for(int t = 0; t < density/colorPack.length; t++){
      toons((int)random(toonDatabase.length), colorPack[l]);
    }
    //group as childs?
  }
  
  
  //draw swatch
  fill(255);
  rect(width-50, 0, 50, height);
  int Y = height-50;
  for(int i = 0; i < colorPack.length; i++){
    fill(colorPack[i]);
    square(width-50, Y, 50);
    Y = Y-70;
  }
}

void toons(int file, int fillColor){
  toonDatabase[file].disableStyle();
  if(fill){ fill(fillColor); }
  else{fill(255);}
  toonDatabase[file].rotate(random(1));
  shape(toonDatabase[file], width/2, height/2, random(width, 1000), random(height, 1000));
}

int colors(){
  color[] simpsons = {
    //color(#FFFFFF), // white
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
  int pick = simpsons[(int)random(simpsons.length)];
  return pick;
}

int goldenColors(){
  color[] golden = {
      color(62, 56, 66),      // Anthraquinone Blue
      color(58, 58, 59),      // Bone Black
      color(110, 69 ,60),     // Burnt Sienna
      color(181, 57, 58),     // C.P. Cadmium Red Medium
      color(255, 188, 32),    // C.P. Cadmium Yellow Medium Hue
      color(61),              // Carbon Black
      color(0, 99, 126),      // Cerulean Blue Deep
      color(88, 111, 77),     // Chromium Oxide Green
      color(21, 85, 161),     // Cobalt Blue
      color(63, 57, 59),      // Dioxazine Purple
      color(109, 117, 55),    // Green Gold
      color(252, 216, 0),     // Hansa Yellow Light
      color(186, 59, 53),     // Napthol Red Light
      color(148, 56, 55),     // Napthol Red Medium
      color(56, 57, 60),      // Paynes Grey
      color(43, 71, 65),      // Phthalo Green (Yellow Shade)
      color(90, 59,62),       // Quinacridone Crimson
      color(115, 69, 59),     // Quinacridone/Nickel Azo Gold
      color(61, 67, 63),      // Sap Green Hue
      color(228, 209, 178),   // Titan Buff
      color(245, 224, 112),   // Titanate Yellow
      color(192, 63, 50),     // Transparent Pyrrole Orange
      color(152, 103, 71),    // Transparent Yellow Iron Oxide
      color(53, 54, 96),      // Ultramarine Blue
      color(2224, 83, 47),    // Vat Orange
      color(193, 136, 69),    // yellow Oxide
      color(242, 243, 240)};  // Zinc White   
    int pick = golden[(int)random(golden.length)];
    return pick;
  }
