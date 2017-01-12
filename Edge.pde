// Code from Visualizing Data, First Edition, Copyright 2008 Ben Fry.
// Based on the GraphLayout example by Sun Microsystems.


class Edge {
  Node from;
  Node to;
  float len;
  int count;
  boolean b_edge = true;
  color color_edge = #ff6666;


  Edge(Node from, Node to) {
    this.from = from;
    this.to = to;
    this.len = 130;
    if(from.colorIsSet){
        color_edge = from.color_node;
    }else {
        color_edge = to.color_node;
    }
  }
  
  
  void increment() {
    count++;
  }
  
  
  void relax() {
    float vx = to.x - from.x;
    float vy = to.y - from.y;
    float d = mag(vx, vy);
    if (d > 0) {
      float f = (len - d) / (d * 3);
      float dx = f * vx;
      float dy = f * vy;
      to.dx += dx;
      to.dy += dy;
      from.dx -= dx*2;
      from.dy -= dy*4;
    }
  }


  void draw() {
    stroke(color_edge,30);
    strokeWeight(5);
    line(from.x, from.y, to.x, to.y);
  }
}