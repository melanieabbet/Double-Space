class Bonus extends GameObject {
   int number;
  //image
  PShape shape;
  //explosion
  PShape boum;
 
  Bonus(PVector position, PVector direction, float diameter, float speed, float damper, int colors1, int colors2) {
    super(position, direction, diameter, speed, damper, colors1, colors2);
    
    number = floor(random(0, 2));//two choice 
    //sound image
    minim = new Minim(this);
    boum= loadShape( "boum.svg");
    
    //choose random image
    if (colors1==0) {
      switch(number) {
      case  0:
        shape = loadShape("bonus1.svg");
        break;
      case  1:
        shape = loadShape("bonus2.svg");
        break;
      }
    }
    
  }
  
  //draw bonus
  void display() {
    super.display(); 
    if (display) {
      shape(shape, position.x- diameter/2, position.y- diameter/2, diameter, diameter);
    }
  }
  //explosion
  void collision() {
    shape(boum, position.x-50, position.y-50, 100, 100);
    astcrash.trigger();
    super.collision();
  };
}