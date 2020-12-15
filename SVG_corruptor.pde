// Brandon A. Dalmer 2019
// Drag and Drop Curruptor

import processing.svg.*;
import geomerative.*;
import drop.*;

//PImage m;

RShape svg; // the SVG
int numLayers; // layers in SVG
RShape layer; // layer of SVG
RStyle style; // style of layer

RShape poly; // polygon of shape
RPoint[] points; // points of shape

SDrop drop;
int count = 0;

////////////////////////////////////////////////////////
/////////////CHANGES////////////////////////////////////
boolean line = false; // lines? no line? - true or false
float lineWidth = 3; // thickness of line
boolean record = false; // change true if you want to save
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

public void setup() {
  RG.init(this);
  size(1200, 1200); // change with SVG load
  strokeWeight(lineWidth);
  noLoop();
  drop = new SDrop(this);
}

public void draw(){
  int glitch = 1;
  if(!line){noStroke();}
  background((int)random(255));
  if(svg != null) {
    for(int i = 0; i < numLayers; i++) { // for each layer
      layer = svg.getChild("Layer_"+i); // grab a layer
      style = layer.getStyle(); // get style from layer
      poly = RG.polygonize(layer); // set layer to polygon
      points = poly.getPoints();
      if(points != null){
        //style!!!!
        RG.shape(layer);
        //beginShape();
        //for(int p = 0; p < points.length; p++){
        //  glitch = (int)random(10);
        //  if(glitch == 6) {
        //    vertex(points[p].x+(int)random(100), points[p].y+(int)random(100));
        //  }
        //  else{vertex(points[p].x, points[p].y);}
        //}
        //endShape();
      }

      println("Layer: "+i+" - Points: "+points.length);
    }
  }
}

public void mousePressed(){
  count = count+1;
  String fileName = "SSN_" + count + ".svg"; // SSN_Year_week-code-version.SVG
  if(record)beginRecord(SVG, fileName);
  if(record)save(fileName+".png");
  redraw();
}

public void dropEvent(DropEvent theDropEvent) { // load data
  if(theDropEvent.isFile()) {
    svg = RG.loadShape(theDropEvent.toString()); // change with SVG load
    numLayers = svg.countChildren(); // count how many layers
    println("Layers: " + numLayers);
  }
}
