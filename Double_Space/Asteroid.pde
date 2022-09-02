class Asteroid extends GameObject {

  int number;
  // image
  PShape shape;
  //explosion
  PShape boum;


  Asteroid(PVector position, PVector direction, float diameter, float speed, float damper, int colors1, int colors2) {
    super(position, direction, diameter, speed, damper, colors1, colors2);
    
    number = floor(random(0, 2)); //two choice 
    //sound image
    minim = new Minim(this);
    boum= loadShape( "boum.svg");
    
    //change the form and color R/B of asteroid with different shape
    if (colors1==0) {
      switch(number) {
      case  0:
        shape = loadShape("ast1R.svg");
        break;
      case  1:
        shape = loadShape("ast2R.svg");
        break;
      }
    } else if (colors1==255) {
      switch(number) {
      case  0:

        shape = loadShape("ast1B.svg");
        break;
      case  1:
        shape = loadShape("ast2B.svg");
        break;
      }
    }
  }
  void display() {
    
    super.display();
    if (display) {
      noStroke();
      //ellipse(position.x, position.y, diameter, diameter);
      
      //rotate
      pushMatrix();
      translate(this.position.x, this.position.y);
      if (colors1==0 && number==1) {
        rotate(radians(turn*-0.5+speed*10));
      }
      if (colors1==0 && number==0) {
        rotate(radians(turn*0.5+speed*10));
      }
      if (colors1==255 && number==1) {
        rotate(radians(turn*-0.5+speed*10));
      }
      if (colors1==255 && number==0) {
        rotate(radians(turn*0.5+speed*10));
      }
      shape(shape, - diameter/2, - diameter/2, diameter, diameter);
      popMatrix();
    }
  }
  
  //draw explosion
  void collision() {
    shape(boum, position.x-50, position.y-50, 100, 100);
    astcrash.trigger();
    super.collision();
  };
}