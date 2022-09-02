class Ship extends GameObject {
  //explosion
  PShape boum;

  //player Red
  PShape shipR;
  PShape shipR2;

  //player Blue
  PShape shipB;
  PShape shipB2;

  Ship(float x, float y, float diameter, float speed, float damper, int colors1, int colors2)
  {
    super(new PVector(x, y), new PVector(0, 1), diameter, speed, damper, colors1, colors2);
    //load image
    boum= loadShape( "boum.svg");
    shipB= loadShape( "shipB.svg");
    shipR= loadShape( "shipR.svg");
    shipB2= loadShape( "shipB2.svg");
    shipR2= loadShape( "shipR2.svg");
  }

  void display()
  {
    super.display();

    pushStyle();
    pushMatrix();
    fill(255, 255, 255);
    translate(position.x, position.y);
    
    //orientation
    rotate(rotation.heading());

    //animation and choose color
    if (colors1==0 && countfly<10) {
      shape(shipB, -50, -50, 100, 100);
    } 
    if (colors1==0 && countfly>=10) {
      shape(shipB2, -50, -50, 100, 100);
    }
    if (colors1==255 && countfly<10) {
      shape(shipR, -50, -50, 100, 100);
    }
    if (colors1==255 && countfly>=10) {
      shape(shipR2, -50, -50, 100, 100);
    }
    popMatrix();
    popStyle();
  }
//change orientation
  void up() {
    rotation.set(0, -1);
    PVector rotationStep = rotation.copy();
    rotationStep.mult(speed);
    velocity.add(rotationStep);
    drawTail();
  }
//change orientation
  void down() { 
    rotation.set(0, 1);
    // rotation.normalize();
    PVector rotationStep = rotation.copy();
    rotationStep.mult(speed);
    velocity.add(rotationStep);
    drawTail();
  }


  void collision() {
    shape(boum, position.x, position.y, 100, 100);
    crashship.trigger();
  };

  void shootLeft() {
    if (colors1==0) {
      torpedoB.add(new Torpedo(position.copy(), new PVector(-1, 0), 0));
    } else {
      torpedoR.add(new Torpedo(position.copy(), new PVector(-1, 0), 255));
    }
  }
  void shootRight() {
    if (colors1==0) {
      torpedoB.add(new Torpedo(position.copy(), new PVector(1, 0), 0));
    } else {
      torpedoR.add(new Torpedo(position.copy(), new PVector(1, 0), 255));
    }
  }

  void drawTail() {  
    int alternator = int(position.x + position.y);
    alternator = alternator%2; // Modulo symbol %, finds the remainder when one number is divided by another 
    if (alternator == 0) {
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotation.heading());
      if (colors1==0) {

        fill(0, 113, 188);
      } else {

        fill(237, 28, 36, 150);
      }

      translate(-(diameter-30)/2, 0);
      triangle(-(diameter-30)*2, 0, -(diameter-30)/5, (diameter-30)/5, -(diameter-30)/5, -(diameter-30)/5);
      popMatrix();
    }
  };
}