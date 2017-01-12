
  
// KEY BOARD USE
//####################################################################################  
  
  
  
  

//############################################
  
int arrangedNodeTime  = 0;
boolean connectionC = false;
void keyPressed() {

    if (key == 'c' && mPressed) {
          connectionC = !connectionC;
          if( connectionC ){
              println("OPENING CONNECTION");
              if (!str_highlight.equals("")){
                myList.add(str_highlight.toUpperCase());
                for (int i = pairs.size()-1; i >= 0; i--) { 
                      wordPair WP = pairs.get(i);
                      if(ignoreWord(WP.firstP) || ignoreWord(WP.secondP) ){
                          loadData(WP.firstP ,WP.secondP);
                      }
                  }
                  openConnection();
              }
          }else{
                 println("FINDING CONNECTION");           
                 findConnection();

          }
    
  }
  
  if (key == 'm' && bubbleToSort > 2) {

      
  }
  
  
 
  
  if (key == 'b') {
    for (int i = 0 ; i < bubbleToSort ; i++) {
      println(str(i) + "   " + nodes[i].label);
      myList.add(nodes[i].label.toUpperCase());
    }
  }
  
  if (key == 'v') {
      println( "PRESSED V ->");
      for (int i = myList.size()-1; i >= 0; i--) {   
          println( myList.get(i));
      }
      
   }  
  
   if (key == 'a') {
        nodesArangeSpeed += 10;
   }
   if (key == 's') {
          if(nodesArangeSpeed <= 10 && nodesArangeSpeed > 2){
               nodesArangeSpeed -= 1;
          }else if(nodesArangeSpeed > 0){
            nodesArangeSpeed -= 10;
          }
   }   
   if (key == 'n') {

      for (int i = pairs.size()-1; i >= 0; i--) { 
          wordPair WP = pairs.get(i);
          if(ignoreWord(WP.firstP) || ignoreWord(WP.secondP) ){
              loadData(WP.firstP ,WP.secondP);
          }
      }

      
  }
  
}

void arrangeBigNode(){
  for(int i = 0; i < myList.size(); i++){
      //Node n = findBigNode();
      Node n = findNode( myList.get(i));
      n.big = true;
      println("FINDING BIG NODES " + n.label);
      switch(i){

        case 0:
              n.x = (width/4);
              n.y = height/4;
          break;
        case 1:
              n.x = (width/4)*3;
              n.y = (height/4)*3;
          break;
        case 2:
              n.x = (width/4)*3;
              n.y = height/(4);
          break;
        case 3:
              n.x = width/(4);
              n.y = (height/4)*3;
         break;
        
      }
        n.fixed = true;
    }
}


Node selection; 

boolean mPressed = false;
void mousePressed() {
  
  
  str_highlight = "";

  // Ignore anything greater than this distance
  float closest = 20;
  for (int i = 0; i < bubbleToSort; i++) {
    Node n = nodes[i];
    float d = dist(mouseX, mouseY, n.x, n.y);
    if (d < closest) {
      str_highlight = n.label;//########################################################################
      mPressed = true; // COLAPSE ONLY WHEN SELECTED ITEM NOT NULL IS; THIS BOOLEAN IS CHECKED IN KEYPRESSED
      
      selection = n;
      closest = d;
    }
  }
  if (selection != null) {
    if (mouseButton == LEFT) {
      selection.fixed = true;
    } else if (mouseButton == RIGHT) {
      selection.fixed = false;
    }
  }
}


void mouseDragged() {
  if (selection != null) {
    selection.x = mouseX;
    selection.y = mouseY;
  }
}


void mouseReleased() {
  selection = null;
  str_highlight="";
  mPressed = false;
}
  
  
  


  
  