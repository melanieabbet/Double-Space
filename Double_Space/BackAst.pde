class BackAst {
  
 PShape fondR;
  PShape fondB;
  
  BackAst() {
 
    fondR = loadShape("Rfond.svg");
    fondB = loadShape("Bfond.svg");
  }

 //draw background
  void affiche(){
     shape(fondB,0,0,width + 0.03* shipB.position.y,height+ 0.04*shipB.position.y);
     shape(fondR,0,0,width + 0.06* shipR.position.y,height+ 0.07*shipR.position.y);
 
  }
}