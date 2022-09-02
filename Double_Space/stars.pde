class Stars{
final int MAX = floor(random(350));
 
float [] x;
float [] y;
float [] dia;
float [] dia2;
float [] dx;
float [] dy;
color [] col;
 
Stars() {
 
  //noStroke ();
  //smooth ();
  //background (0);
 
  x = new float [MAX];
  initializeFloatArray (x, 0, 13*width);
 
  y = new float [MAX];
  initializeFloatArray (y, 0, 9*height);
 
  dx = new float [MAX];
  initializeFloatArray (dx, .5, 0.2);
 
  dy = new float [MAX];
  initializeFloatArray (dy, 0.5, 0.2);
 
  dia = new float [MAX];
  initializeFloatArray (dia, 0, height);
   
  dia2 = new float [MAX];
  initializeFloatArray (dia2, 0, 1);
   col = new color [MAX];
  initializeColorArray();
}
 
 
void dessin () {
 background(0);
  drawEllipse ();
  growEllipse ();
  moveEllipse ();
  
}
 
void initializeFloatArray (float [] now, float low, float high) {
  for (int i = 0; i < now.length; i++) {
    now [i] = random (low, high);
  }
}
 
void initializeColorArray(){
  for (int i = 0; i < col.length; i++){
  //col[i] = color(random (255), random (255), random (255), 150);
     int randomChance1 = floor(random(0, 2));
    int a;
     if (randomChance1==1) {
    
    a = color( 0,113, 188);
     }
     else {
    a = color( 237,28, 36);
    
     }
     col[i]= a;
     //col[i] = color( a, 255);
  }
}
 
void drawEllipse () {
  for (int i = 0; i < x.length; i++) {
    fill (col [i],200);
    ellipse (x [i], y[i], dia[i], dia[i]);
  }
}
 
void growEllipse () {
  for (int i = 0; i < x.length; i++) {
    dia[i] += dia2[i];
    if (dia[i] > random (height*0.001, height*0.011)) {
      dia[i] = 0;
    }
  }
}
 
void moveEllipse () {
  for (int i = 0; i < dx.length; i++) {
    x[i] += 2*dx[i];
    if (x[i] > width) {
      x[i] = 0;
    }
    y[i] += 2*dy [i];
 
      if (y[i] > height ) {
        y[i] = 0;
      }
    }
  }
 
}