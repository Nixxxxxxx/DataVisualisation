/**

  key : b - add word to mylist of words to filter
      . n - show the new connection
      . m - place bubble apart from one another
      . c( while bubble is selected) - colapse the bubble
      . v - show in console the list of words in mylist

 **/

//import de.bezier.data.*;


int bubbleToSort;
Node[] nodes = new Node[40000];
HashMap nodeTable = new HashMap();
String lines2[];

int edgebubbleSize;
Edge[] edges = new Edge[60000];

static final color nodeColor   = #FF9070;
static final color selectColor = #FF3030;
static final color fixedColor  = #FF8080;
static final color edgeColor   = #000000;
color [] colarray = { color(50,205,50), color(205,105,205),
 color(50,50,250), color(50,205,235), color(145,205,50),color(155,50,250), color(100,100,100) };

PFont font;
PFont font_highlight;

String str_highlight = "";
ArrayList<String> myList;
int nodesArangeSpeed = 10;

void setup ()
{
  pairs = new ArrayList<wordPair>();
  myList = new ArrayList<String>();
  myList.add(new String("party"));
  myList.add(new String("poker"));
  myList.add(new String("games"));
  myList.add(new String("tree"));
 
  lines2 = loadStrings("list2.txt");
  init_xlsFile();
  

  
  size(1350, 700);  // SCRENN SIZE
  println("edgebubbleSize  "+ str(edgebubbleSize));
  
  // printArray(PFont.list());
  font_highlight = createFont("Georgia", 30); // this font will be use for highlighting
  font = createFont("SansSerif", 6);
  textFont(font);  
  
  for (int i = myList.size()-1; i >= 0; i--) {   
          findNode(myList.get(i)).color_node = colarray[i%7];
          findNode(myList.get(i)).sz = 20;
          findAndColor(findNode(myList.get(i)).label);  
          findNode(myList.get(i)).colorIsSet = true;       
  }
  arrangeBigNode();
}
//#############END OF SETUP###########################################
//********************************************************************
// DISPLAYING LABEL ON UPPER-RIGHT SIDE OF WINDOW
//********************************************************************
void nodeHighlight(String s1){
    textFont(font_highlight);
    textAlign(LEFT);
    fill(0);
    text(s1, width * 0.85, 95);
  
    textFont(font);
}
//********************************************************************

//XlsReader reader;
ArrayList<wordPair> pairs;

int lines = 1;


void init_xlsFile(){
    // assumes file to be in the data folder
    String s1 = "", s2= "XX", str;
    for (int i = 0 ; i < lines2.length; i++) {
           try{
              str = lines2[i];
              s1 = str.split(" ")[0];
              s2 = str.split(" ")[1];
           }catch (Exception e){
                 e.printStackTrace();
           }
         pairs.add(new wordPair(s1,s2));
         if(ignoreWord(s1) || ignoreWord(s2) ){
                      addEdge(s1 ,s2);
         
          }
          lines++;
   }
  printPairAndLoad();
 
}

void printPairAndLoad(){
  
  println("\n ************\n++***************\n" );
    for (int i = pairs.size()-1; i >= 0; i--) { 
        // An ArrayList doesn't know what it is storing so we have to cast the object coming out
          wordPair WP = pairs.get(i);
           println(str(i) + "   " + WP.firstP + "   " + WP.secondP);
    } 
    println("\nWORDPAIR ARRAY SIZE " + str(pairs.size()));
      
}  
  
void addEdge(String fromLabel, String toLabel) {
  // Filter out unnecessary words
  if (ignoreWord(fromLabel) || ignoreWord(toLabel)) {
       

  }else{
        println("Returning    " + fromLabel + "  "+ toLabel );
        return;
  }
  Node from = findNode(fromLabel);
  Node to = findNode(toLabel);
  from.increment();
  to.increment();
  
  for (int i = 0; i < edgebubbleSize; i++) {
    if (edges[i].from == from && edges[i].to == to) {
      edges[i].increment();
      return;
    }
  } 
  
  Edge e = new Edge(from, to);
  e.increment();
  if (edgebubbleSize == edges.length) {
    edges = (Edge[]) expand(edges);
  }
  edges[edgebubbleSize++] = e;
}

//#####################################################################
//################# IGNORE NOT WORDS #########################################
//######################################################################

boolean ignoreWord(String what) {
   for (int i = myList.size()-1; i >= 0; i--) {   
     String sFilter = myList.get(i);
     if (what.equals(sFilter)) {
      return true;
     }
  }
  
  return false;
}
//#########################################################################################################



Node findNode(String label) {
  label = label.toLowerCase();
  Node n = (Node) nodeTable.get(label);
  if (n == null) {
    return addNode(label);
  }
  return n;
}


//********************************************************************
//********************************************************************
void findConnection(){

  // ALSO HAVE TO DO THE TO
  for (int i = 0; i < edgebubbleSize; i++) {
      if (edges[i].from.label.equals(str_highlight) ) {
           if(!findEdges(edges[i].from.label,edges[i].to.label, i) ){//####################### replace i with 0
               edges[i].to.bubbleSize = 1;
               edges[i].len = (edges[i].from.bubbleSize/2)+2;
           }
      }
     if (edges[i].to.label.equals(str_highlight) ) {
           if(!findEdges(edges[i].to.label,edges[i].from.label,i) ){ // ################################
               edges[i].from.bubbleSize = 1;
               edges[i].len = (edges[i].to.bubbleSize/2)+2;
           }
     }
  } 


}

//########################################################################
//########################################################################
void openConnection(){

  // ALSO HAVE TO DO THE TO
  for (int i = 0; i < edgebubbleSize; i++) {
      if (edges[i].from.label.equals(str_highlight) ) {
           if(!findEdges(edges[i].from.label,edges[i].to.label, i) ){//####################### replace i with 0
               edges[i].to.bubbleSize = edges[i].from.bubbleSize;
               edges[i].len = 130;
           }
      }
     if (edges[i].to.label.equals(str_highlight) ) {
           if(!findEdges(edges[i].to.label,edges[i].from.label,i) ){ // ################################
               edges[i].from.bubbleSize = edges[i].to.bubbleSize;
               edges[i].len = 130;
           }
     }
  } 


}









//################ COLOR FIRST ORDER LINKS ###############################
//########################################################################
/*
    Go through all the links/verbinungs and find nodes connected to only
    one Main Node and change its color to that of the main node
*/
void findAndColor(String s1){
  for (int i = 0; i < edgebubbleSize; i++) {
    if (edges[i].from.label.equals(s1) ) {
         if(!findEdges(edges[i].from.label,edges[i].to.label, i) ){
             edges[i].to.color_node = edges[i].from.color_node;
             edges[i].color_edge = edges[i].from.color_node;
         }
    }
   if (edges[i].to.label.equals(s1) ) {
         if(!findEdges(edges[i].to.label,edges[i].from.label,i) ){
             edges[i].from.color_node = edges[i].to.color_node;
             edges[i].color_edge = edges[i].to.color_node;
         }
    }
  } 
}
//######################  END OF COLORING  ###############################

//*******************************************************************
//*****************************************************************
//############################################################
//############################################################
boolean findEdges(String main_node, String label, int z) {
  int e_bubbleSize = 0;   

  for (int i = 0; i < edgebubbleSize; i++) {
     if (edges[i].from.label.equals(label) && i != z &&  !edges[i].to.label.equals(main_node)) { 
        e_bubbleSize++;    
     }
     if (edges[i].to.label.equals(label) && i != z && !edges[i].from.label.equals(main_node)) { 
        e_bubbleSize++;
     }
        
     if(e_bubbleSize >= 1){
       println(label + "    from  "+ edges[i].from.label+ "   to "+ edges[i].to.label + "  " + str(i)+ "  "+ str(z));

       return true; 
     }   
  } 
  return false;
}
//############################################################
//############################################################
Node findBigNode(){
  Node n = nodes[0];
  for (int i = 1; i < bubbleToSort; i++) {
    if( nodes[i].numOfNodes > n.numOfNodes && !nodes[i].big ){
       n = nodes[i];
    }
  }
  return n;
}




//############################################################

Node addNode(String label) {  
  Node n = new Node(label);  
  if (bubbleToSort == nodes.length) {
    nodes = (Node[]) expand(nodes);
  }
  nodeTable.put(label, n);
  nodes[bubbleToSort++] = n;  
  return n;
}


/*
######################################################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   
//++++++++++++++++++++++++++++++++++++ LOOP OF MAIN PROGRAM ++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
######################################################################################################
*/


void draw() {
  background(255);
  BasicDraw(); 
  nodeHighlight(str_highlight);
}


void BasicDraw(){
  for (int i = 0 ; i < edgebubbleSize ; i++) {
    edges[i].relax();
  }
  for (int i = 0; i < bubbleToSort; i++) {
    nodes[i].relax();
  }
  for (int i = 0; i < bubbleToSort; i++) {
    nodes[i].update();
  //  textSize(8);
  }
  for (int i = 0 ; i < edgebubbleSize ; i++) {
    edges[i].draw();
  }
  for (int i = 0 ; i < bubbleToSort ; i++) {
    nodes[i].draw();
  }
  
  
}