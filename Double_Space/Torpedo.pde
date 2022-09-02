class Torpedo extends GameObject {
  
  Torpedo(PVector position, PVector direction,int colors1)
  {
    super(position, direction, 7, 10, 1,colors1,255 );   // position,  direction,  diameter, speed, damper
  }

  void display()
  {
    super.display();
    if (display) {
      pushStyle();
      
      //choose color
      if (colors1==0) {
        fill(0, 113, 188);
      } else if (colors1== 255){
        fill(237, 28, 36, 150);
      }
      
      noStroke();
      ellipse(position.x, position.y, diameter, diameter);
      popStyle();
    }
  }
  void screenWrap() {
    // overide screenWrap and hide torpedos if they are off screen 
    if (position.x > width || position.x < 0 || position.y > height || position.y < 0) {
      display = false;
    }
  }
}