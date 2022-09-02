class Paus {
  
  PShape pause;
  
  Paus() {

    pause = loadShape("pause1.svg");
  }
  void affiche(){
    filter(GRAY);
   

   fill(0,0,0,5);
   rect(0,0,width,height);
    shape(pause, width/2-200, height/2-200, 400, 400);
  }
}