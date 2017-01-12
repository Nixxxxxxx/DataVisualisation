// Code from Visualizing Data, First Edition, Copyright 2008 Ben Fry.
// Based on the GraphLayout example by Sun Microsystems.


class Node {
  float x, y;
  float dx, dy;
  boolean fixed, b_node = true;
  public String label;
  int bubbleSize = 50;
  int sz = 20; 
  int numOfNodes = 0;
  boolean big = false;
  color color_node = #ff5050;
  int alphaColorChanel = 5;
  boolean colorIsSet = false;

  Node(String label) {
    this.label = label;
    x = random(width);
    y = random(height);
  }
  Node(String label, color col) {
    this.label = label;
    x = random(width);
    y = random(height);
    color_node = col;
    colorIsSet = true;
  }
  
  void increment() {   
    bubbleSize+=2;
    if(bubbleSize > 150) bubbleSize = 150;
    numOfNodes++;
    
  }
  
  void configNode(){
    alphaColorChanel = 50 * numOfNodes; 
    if(sz <= 60 &&  numOfNodes < 10 ){
          sz = 20 + numOfNodes;
    }
    
  }
  
  void relax() {
    float ddx = 0;
    float ddy = 0;

    for (int j = 0; j < bubbleToSort; j++) {
      Node n = nodes[j];
      if (n != this) {
        float vx = x - n.x;
        float vy = y - n.y;
        float lensq = vx * vx + vy * vy;
        if (lensq == 0) {
          //ddx += random(1);
         // ddy += random(1);
        } else if (lensq < 100*100) {
          ddx += vx / lensq;
          ddy += vy / lensq;
        }
      }
    }
    
    float dlen = mag(ddx, ddy) / 2;
    if (dlen > 0) {
      dx += ddx / dlen;
      dy += ddy / dlen;
    }
  }

  void update() {
    
    if (!fixed) {      
      //x += constrain(dx, -(width+200), width-250);
      //y += constrain(dy, -(height+250), height-250);
      
      x += constrain(dx, -nodesArangeSpeed, nodesArangeSpeed);
      y += constrain(dy, -nodesArangeSpeed, nodesArangeSpeed);
      
      x = constrain(x, 0, width);
      y = constrain(y, 0, height);
    }
    dx /= 2;
    dy /= 2;
  }


int setDrawFrame = 1;
  void draw() {
      setDrawFrame++;
          
        fill(color_node,alphaColorChanel);
        stroke(color_node,alphaColorChanel);
        strokeWeight(4);
        
        ellipse(x, y, bubbleSize, bubbleSize);
        float w = textWidth(label);
    
        if (bubbleSize > w+2) {
          fill(0);
          textSize(sz);
          textAlign(CENTER, CENTER);
          text(label, x, y);
        }else{
          fill(0);
          textSize(sz/2);
          textAlign(CENTER, CENTER);
          text(label, x, y);
          
        }
      
  }
}