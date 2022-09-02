class GameObject {
  boolean   display;
  PVector   position = new PVector();
  PVector   velocity = new PVector();
  PVector   rotation = new PVector();
  float     damper;
  float     diameter;
  float     speed;
  float     radius;
  int colors1 ;
  int colors2;

  GameObject(PVector position, PVector direction, float diameter, float speed, float damper, int colors1, int colors2)
  {
    this.position = position; 
    this.velocity = direction.normalize();
    this.damper = damper; // damper acts like resistance againsts the object, slowing it down over time
    this.rotation = velocity.copy();
    this.speed = speed;
    this.velocity.mult(speed); //velocity is the combination of speed and direction 
    this.diameter = diameter;
    this.radius = diameter/2;
    this.display = true;
    this.colors1 =colors1;
    this.colors2 =colors2;
  }

  void display()
  {
    if (display) {
      velocity.mult(damper);
      position.add(velocity);
      screenWrap();
    }
  }

  void collision() {
    display = false; //  animation explosion
  };

  boolean checkCollision(GameObject otherObject) {
    // Circle Collision Detection
    float distance = dist(position.x, position.y, otherObject.x(), otherObject.y());
    if (distance < radius + otherObject.radius) {
      // collsiion did happen
      this.collision();
      otherObject.collision();
      return true;
    } else {
      return false;
    }
  }

  float x() {
    return position.x;
  }

  float y() {
    return position.y;
  }

  void screenWrap() {
    // make sure objects always stay on screen by wraping the game space.
    // check if object is off screen to the right
    // if (position.x > width+radius)
    // {
    //  position.x = 0-radius;
    // }
    // check if object is off screen to the left
    // if (position.x < 0-radius)
    // {
    //   position.x = width+radius;
    // }
    // check if object is off screen to the bottom
    if (position.y+velocity.y >= height-radius)
    {
      PVector temp = velocity.copy();
      temp.mult(1.5);
      temp = temp.rotate(radians(180));
      velocity.add(temp);
    }
    // check if object is off screen to the top
    if (position.y+velocity.y <= 0+radius)
    {
      
      PVector temp = velocity.copy();
      temp.mult(1.5);
      temp = temp.rotate(radians(180));
      velocity.add(temp);
    }
  }
}