import drop.*;
///////////////////////////////////////////////// 
// Brandon A. Dalmer - 2023
// Image transcode - image to text - 82 X 110 pixels = 36" X 48"
///////////////////////////////////////////////// 

File myFile;
SDrop drop;
PImage file;
float code = 0; // color tint 0-255
PrintWriter output;

///////////////////////////////////////////////// 
void setup(){
  size(250,250);
  textSize(32);
  textAlign(CENTER);
  fill(0);
  drop = new SDrop(this);
  text("DRAG 2 TEXT", width/2, height/2);
}

///////////////////////////////////////////////// GENERATE TEXT
void draw(){
  if(file != null){
    output = createWriter("Mariner_4_output"+month()+year()+".txt");
    file.loadPixels();
    for(int y = 0; y < file.height; y++){
      for(int x = 0; x < file.width; x++){
        int loc = x + y*file.width;
        float r = red(file.pixels[loc]);
        float g = green(file.pixels[loc]);
        float b = blue(file.pixels[loc]);
        code = (r+g+b)/3; // B&W average
        println(code);
        String txt = nf((int)code, 3);
        output.print(txt+" ");
      }
      output.println();
      output.println();
    }
    output.flush();
    output.close();
    exit();
    }
}

///////////////////////////////////////////////// LISTEN FOR DROP
void dropEvent(DropEvent theDropEvent){
  if(theDropEvent.isImage()){
    file = theDropEvent.loadImage();
  }
}
