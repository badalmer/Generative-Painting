// LINE GENERATOR - Based on Dither Patterns
import processing.svg.*;
PGraphicsSVG svg;

void setup() {
 size(648, 864);
 noLoop();
 beginRecord(SVG, "lines-#####.svg");
}

void draw(){
  background(255);
  for(int y = 0; y < height; y+=15){ //vertical 
    for(int x = 0; x <width; x+=15){ //horizontal
      float n = random(5, 8);
      strokeWeight(4);
      line(x, y, x, y+random(15)); // vertical distribution
      line(x-n, y+n, x+n, y); // horizontal distribution
    }
  }
  endRecord();
}

void mousePressed(){
  int y = year();
  saveFrame("SSN//"+y+"_cross###.png");
  redraw();
}
