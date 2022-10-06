import processing.svg.*;

// Brandon A. Dalmer 2022
// Generative Noise Map [blockchain] - processing
// example hash "0x11ac128f8b54949c12d04102cfc01960fc496813cbc3495bf77aeed738579738"

int editionMax = 666;
String hash = "0x1626fddc1ea6ce7f2bfd337269f4f3c18533a4435b1fa95e486b243260d6e5bc";
int[] valueArray = new int[hash.length()/2]; // 30
int[] greyPack = new int[10];
float zoff[] = new float[2];
boolean single = true;
boolean record = true;


void setup(){
  size(1800, 825);
  background(255);
  noLoop();
  
  // hash info into an array
  int arrayNum = 0;
  hash = hash.substring(2, hash.length()); // minus 0x from string
  for(int h = 0; h < hash.length(); h+=2){
    int value = hashVals(hash, h, h+2);
    valueArray[arrayNum] = value;
    arrayNum +=1;
  }
  
  // assign greys
  int grey = 0;
  for(int g = 0; g < valueArray.length-3; g+=3){
    greyPack[grey] = (valueArray[g] + valueArray[g+1] + valueArray[g+2])/3;
    grey+=1;
  }
}

void draw(){
  if(!single){
    if(record){beginRecord(SVG, "0x"+hash.toString()+".svg");}
      displayHash(width/2, 800, 20);
      int posX = 0;
      for(int p = 0; p < greyPack.length/2; p++){
        push();
        translate(posX, 0);
        drawStream(greyPack[p]);
        pop();
        posX += width/5;
      }
      posX = 0;
      for(int p = greyPack.length/2; p < greyPack.length; p++){
        push();
        translate(posX, 360);
        drawStream(greyPack[p]);
        pop();
        posX += width/5;
      }
    if(record){endRecord();}
  }
  else{
    int pick = 0;
    if(record){beginRecord(SVG, "0x"+hash.toString()+"["+pick+"]"+".svg");}
    push();
    translate(100, 50);
    drawStream(greyPack[pick]);
    displayHash(0, 450, 10);
    pop();
    if(record){endRecord();}
  }
}


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
void drawStream(color seed) {
  stroke(seed);
  strokeWeight(1);
  noiseSeed(seed);
  float nx = 0;
  for (int i= 0; i < width/5; i += 10) {
    float ny = 0;
    for (int j= 0; j < width/5; j += 10) {
      float angle = map (noise (nx, ny), 0, 1.0, 0, 4*PI);
      float x = 50 * cos (angle);
      float y = 50 * sin (angle);
      line (i, j, i+x, j+y);
      ny += 0.005;
    }
    nx += 0.005;
  }
}


void flowField(color fill){
  int var = 6;
  strokeWeight(3);
  int cols, rows;
  float inc = 0.09;
  PVector v;
  cols = floor(width / var);
  rows = floor(height / var);
  float yoff = 0;
  for(int y = 0; y < rows; y+=2){
    float xoff = 0;
    for(int x = 0; x < cols; x+=4){
      //float angle = random(0, PI)/scl;
      float angle = round(noise(xoff, yoff, zoff[1]) * TWO_PI /var);
      noiseDetail(3, 0.5);
      //float angle = noise(xoff, yoff, zoff) * TWO_PI;
      //float r = noise(xoff, yoff) * 255;
      v = PVector.fromAngle(angle);
      xoff += inc;
      //stroke(colorPack[int(random(0, 2))]);
      //stroke(colorPack[int(random(colorPack.length))]);
      stroke(fill);
      push();
      translate(x*var, y*var);
      rotate(v.heading());
      line(0, 0, var+20, 0);
      pop();
      
    }
    yoff += inc;
    zoff[1] += 0.0005;
  }
}

// Display Hash
void displayHash(int x, int y, int size){
  fill(0);
  if(!single){textAlign(CENTER);}
  textSize(size);
  text("Hashcode: 0x"+hash.toString(), x, y);
  if(single){
    for(int i = 0; i < 3; i++){ 
      text("["+valueArray[i]+"]", x, y-20);
      x+=20;
    }
  }
}


// translate Hash to integers
int hashVals(String hashcode, int a, int b){
  String hex = hashcode;
  int val = Integer.parseInt(hex.substring(a, b), 16);
  return val;
}

// average value from array
int averageVal(){
  int average = 0;
  for(int h = 0; h < valueArray.length; h++){
    average += valueArray[h];  
  }
  average /= valueArray.length; 
  return average;
}
