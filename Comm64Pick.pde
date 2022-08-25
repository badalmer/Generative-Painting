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
