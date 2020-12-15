// Brandon A. Dalmer 2020 - Perlin Noise Bench
import processing.svg.*;

int time;
PShape noise, lines;
int count = 0;
boolean record = false;

float xoff = 0.0;
void setup() {
  size(864, 1152);
  noLoop();
  noiseDetail(100);
}

void draw() {
  time = (int)random(30,60); // time = random between 30min - 1 hr
  println(time);
  if(record){beginRecord(SVG, count+"_"+time+".svg");}
  //background(255);
  noiseGen();
  //lines();
  if(record){endRecord();}
  count ++;
}

void mousePressed(){
  redraw();
}

void noiseGen(){ // perlin lines
  // perlin noise vector
  noFill();
  stroke(255,0,0);
  strokeWeight(1);
  float yoff = time;
  for(int y = 0; y < height+100; y+=5) {
    float xoff = 0;
    beginShape();
    for(int x = 0; x < width; x+=2) {
      float n = noise(xoff, yoff);
      float wave = map(n, 0, 1, -100, 10);
      curveVertex(x, y+wave);
      xoff += 0.01;
    }
    endShape();
    yoff += 0.09;
  }
}

void lines(){ // horizontal lines
  // vector lines
  for(int i = 0; i < height; i = i+3) {
    stroke(0);
    strokeWeight(1);
    line(0, 0+i, width, 0+i);
  }
}
