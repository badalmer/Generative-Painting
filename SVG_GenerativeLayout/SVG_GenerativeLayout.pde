// Brandon A. Dalmer 2022
// Panel Layout Creator
import processing.svg.*;

int col, row;
int margin = 10;
int fileNum = 25;
PShape[] toonDatabase = new PShape[fileNum];
color[] colorPack = new int[6]; // number of colors max 8
boolean colorRefresh = false;
boolean pngOut = true;

void setup() {
  size(800, 800);
  noLoop();
  // load samples
  for(int i = 0; i < fileNum; i++){
    toonDatabase[i] = loadShape(i+".svg");
    toonDatabase[i].disableStyle();
  }
  // load colors
  for(int c = 0; c < colorPack.length; c++){
    colorPack[c] = Comm64Pick();
  }
}

void draw() {
  if (colorRefresh){ // reload colors
    for(int c = 0; c < colorPack.length; c++){
      colorPack[c] = Comm64Pick();
    }
  }
  translate(width/2, height/2);
  scale(0.98);
  translate((-width/2)+margin/2, (-height/2)+margin/2);
  noise();
  panels();
  if(pngOut){saveFrame("layout-######.jpg");}
}

void mouseClicked(){
  redraw();
}

void keyPressed(){
  if(key == 'r' || key == 'R'){colorRefresh = true;}// refresh color
  if(key == 'h' || key == 'H'){colorRefresh = false;}// refresh color
}

////////////////////////////////////

void noise(){
  float inc = 0.02;
  loadPixels();
  float xoff = 0.0;
  float detail = map(255,0,width, 0.1, 0.6);
  noiseDetail(8,detail);
  for(int x = 0; x < width; x++){
    xoff += inc; 
    float yoff = 0.0;
    for(int y = 0; y < height; y++){
      yoff += inc;
      float bright = noise(xoff, yoff)*255;
      pixels[x+y*width] = color(bright);
    }
  }
  updatePixels();
}

void panels() {
  strokeWeight(2);
  col = int(random(1, 5));
  row = int(random(1, 5));
  int w = width/row;
  int h = height/col;
  for(int r = 0; r < row; r++){
    for(int c = 0; c < col; c++){
      int x = r*w;
      int y = c*h;
      fill(colorPack[(int)random(colorPack.length)]);
      rect(x, y, w-margin, h-margin);
      for(int i = 0; i < 100; i++){
        drawSVG(x, y, w-margin, h-margin);
      }
    }
  }
}

void drawSVG(int x_, int y_, int w_, int h_){
  PGraphics svg = createGraphics(w_, h_);
  int file = (int)random(fileNum);
  float h = random(500, h_ * 0.5);
  float w = random(500, w_ * 0.5);
  float x = (random(-3, 3)) * svg.width;
  float y = (random(-3, 3)) * svg.height;
  svg.beginDraw();
  svg.noStroke();
  svg.fill(colorPack[(int)random(colorPack.length)]);
  svg.pushMatrix();
  svg.translate(0,0);
  svg.rotate(random(180));
  svg.shape(toonDatabase[file], x, y, w, h);
  svg.popMatrix();
  svg.endDraw();
  image(svg, x_, y_);
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
  return pick;
}
