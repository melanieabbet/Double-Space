//sound //<>//
import ddf.minim.*;
Minim minim;

//sound player and keyboard
AudioPlayer player;
AudioSample move;
AudioSample crashship;
AudioSample tire;

//sound object
AudioSample astcrash;

//sreen design
Paus Pauss;
boolean gamePause = false; //pause mode
BackAst BackAsts;
Stars Stars1 =new Stars();
PShape start;
PShape endB;
PShape endR;
int gameStatus = 0;  
final int startScreen = 0;
final int playingGame = 1;
final int gameOverB = 2;
final int gameOverR= 3;
final color palette1 = color(0);

//score
PFont font;
int currentScoreB = 0;
int highscoreB = 0;
int currentScoreR = 0;
int highscoreR = 0;

//player Blue=B Red=R , without is for both player
boolean shootLimit; // used to limit torpedos to one per click
float countfly = 0; // use to animate the ship,to switch between two images
Ship shipB;
Ship shipR;
ArrayList<Torpedo> torpedoR;
ArrayList<Torpedo> torpedoB;
boolean keyDownR = false;
boolean keyDownB = false;
boolean keyUpR = false;
boolean keyUpB = false;

//object Blue=B Red=R, without is for both player
ArrayList<Bonus> bonus;
ArrayList<Asteroid> asteroidsR;
ArrayList<Asteroid> asteroidsRvitesse;
ArrayList<Asteroid> asteroidsB;
ArrayList<Asteroid> asteroidsBvitesse;
float countV = 0; //use for to increase asteroidRvitesse andasteroidBvitesse
boolean ecranjeuon =false;// if drawgame is activ counv would be increase
boolean countvfin =false;// use to reset the countV if its gameover
int gameCount = 0; // counter to draw new Asteroid 
float turn = 0; // use to rotate the Asteroid
float countNb = 0;// use to increase the number of Asteroid


void setup() { 
  //size(1000, 600); 
  fullScreen(); 
  setupGame(); 
  noCursor();

  //load font style
  font = loadFont("AvenirNext-Medium-20.vlw");

  //load sound check volume
  minim = new Minim(this);
  player = minim.loadFile("play2.mp3"); 
  move = minim.loadSample("move2.mp3");
  astcrash = minim.loadSample("astcrash.mp3");
  astcrash.setGain(-5);
  tire =minim.loadSample("tire.mp3");
  tire.setGain(-5);
  crashship =minim.loadSample("crashship.mp3");
  crashship.setGain(-8);
}

//change statut game
void draw() {
  switch(gameStatus) {
  case startScreen:
    drawStartScreen();
    break;
  case playingGame:
    drawGame();
    break;
  case gameOverB:
    drawGameOverBScreen();
    break;
  case gameOverR:
    drawGameOverRScreen();
    break;
  }
}


void setupGame()
{
  //player
  shipB = new Ship((width/2)-50, height/2, 70, .1, .9990, 0, 255);
  shipR = new Ship((width/2)+50, height/2, 70, .1, .9990, 255, 0);
  torpedoR = new ArrayList<Torpedo>();
  torpedoB = new ArrayList<Torpedo>();

  //object
  bonus = new ArrayList<Bonus>();
  asteroidsR = new ArrayList<Asteroid>();
  asteroidsRvitesse = new ArrayList<Asteroid>();
  asteroidsB = new ArrayList<Asteroid>();
  asteroidsBvitesse = new ArrayList<Asteroid>();
  asteroidFactory(4);
  bonusFactory(2);
  asteroidFactoryvitesse(2);

  //screen design
  BackAsts = new BackAst();
  Pauss =new Paus();
  start = loadShape("start2.svg");
  endB = loadShape("endscreenB.svg");
  endR = loadShape("endscreenR.svg");
}

// bonus fonction Randomly position bonus around the game 
void bonusFactory(int nobonus) {
  for (int i = 0; i < nobonus; i++) {
    int randomChance = floor(random(0, 2)); 
    float offset;// to hide the asteroid at begining
    float diameter = 20;
    PVector bonusDirection;// to change the direction
    if (randomChance==1) {
      offset = diameter;
      bonusDirection = new PVector(-1, 0);
    } else {
      offset = -diameter;
      bonusDirection = new PVector(1, 0);
    }
    PVector bonusPosition = new PVector((randomChance*width)+offset, random(height)); 
    float speed = (random(0.05, 1.0));
    float damper = 1;
    bonus.add(new Bonus(bonusPosition, bonusDirection, diameter, speed, damper, 0, 255));
  }
}


//Randomly position asteroidsR and asteroidsB around the game 
void asteroidFactory(int noAsteroids) {
  for (int i = 0; i < noAsteroids; i++) {
    int randomChance = floor(random(0, 2));//make a 2 choose option
    float offset;// to hide the asteroid at begining
    float diameter = random(30)+20;
    PVector asteroidsDirection;// to change the direction
    if (randomChance==1) {
      offset = diameter;
      asteroidsDirection = new PVector(-1, 0);
    } else {
      offset = -diameter;
      asteroidsDirection = new PVector(1, 0);
    }
    PVector asteroidsRPosition = new PVector((randomChance*width)+offset, random(height));
    PVector asteroidsBPosition = new PVector((randomChance*width)+offset, random(height));
    float speed = (random(0.05, 1.0));
    float damper = 1;
    asteroidsR.add(new Asteroid(asteroidsRPosition, asteroidsDirection, diameter, speed, damper, 0, 255));
    asteroidsB.add(new Asteroid(asteroidsBPosition, asteroidsDirection, diameter, speed, damper, 255, 0));
  }
}

//Randomly position asteroidsRvitesse and asteroidsBvitesse around the game 
void asteroidFactoryvitesse(int noAsteroidsvitesse) {
  for (int i = 0; i < noAsteroidsvitesse; i++) {
    int randomChance = floor(random(0, 2));
    float offset; // to change the direction
    float diameter = random(30)+20;
    PVector asteroidsDirection;
    if (randomChance==1) {
      offset = diameter;
      asteroidsDirection = new PVector(-1, 0);
    } else {
      offset = -diameter;
      asteroidsDirection = new PVector(1, 0);
    }
    PVector asteroidsRPositionvitesse = new PVector((randomChance*width)+offset, random(height));
    PVector asteroidsBPositionvitesse = new PVector((randomChance*width)+offset, random(height));
    float speed2 = (random(0.05, 0.5))+countV;
    float damper = 1;
    asteroidsRvitesse.add(new Asteroid(asteroidsRPositionvitesse, asteroidsDirection, diameter, speed2, damper, 0, 255));
    asteroidsBvitesse.add(new Asteroid(asteroidsBPositionvitesse, asteroidsDirection, diameter, speed2, damper, 255, 0));

    //increse the vitesse
    if (ecranjeuon) {
      countV=countV+0.05;
    }
    //reset
    if (countvfin) {
      countV = 0;
      countvfin=false;
    }
  }
}

//score definition
void drawScores() {
  pushStyle();
  fill(0, 113, 188); 
  textFont(font);
  textSize(20);
  textAlign(LEFT);
  text("Score   "+   currentScoreB, width/2-140, 60);
  fill(165, 25, 42);
  text("Score   "+   currentScoreR, width/2+35, 60);
  popStyle();
  if (currentScoreB > highscoreB && gameStatus == gameOverR) {
    highscoreB = currentScoreB;
  }
  if (currentScoreR > highscoreR && gameStatus == gameOverB) {
    highscoreR = currentScoreR;
  }
}

//*************
// game screens
//*************

void drawStartScreen() {
  background(palette1);
  shape(start, 0, 0, width, height);
}

void drawGameOverBScreen() {

  //design
  background(palette1);
  shape(endB, 0, 0, width, height);
  //reset
  countvfin =true;
  //sound stop
  player.pause();

  //text score
  pushStyle();
  fill(0, 113, 188); 
  textFont(font);
  textSize(20);
  textAlign(CENTER);
  text("Your Score : "+ 0, width/2-100, 60);
  fill(165, 25, 42); 
  text("Your Score : "+ currentScoreR, width/2+100, 60);
  fill(89, 14, 24);
  text("Highscore : "+ highscoreR, width/2+100, 85);
  fill(2, 62, 96); 
  textFont(font);
  textSize(20);
  text("Highscore : "+ highscoreB, width/2-100, 85);
  popStyle();
}
void drawGameOverRScreen() {
  //design
  background(palette1);
  shape(endR, 0, 0, width, height);
  //reset
  countvfin =true;
  //sound stop
  player.pause();

  //text
  pushStyle();
  fill(0, 113, 188); 
  textFont(font);
  textSize(20);
  textAlign(CENTER);
  text("Your Score : "+ currentScoreB, width/2-100, 60);
  fill(165, 25, 42); 
  text("Your Score : "+ 0, width/2+100, 60);
  fill(89, 14, 24);
  text("Highscore : "+ highscoreR, width/2+100, 85);
  fill(2, 62, 96); 
  textFont(font);
  textSize(20);
  text("Highscore : "+ highscoreB, width/2-100, 85);
  popStyle();
}


void drawGame() {

  if (gamePause == false) {
    // counter to draw new Asteroid 
    gameCount++;
    // use to rotate the Asteroid
    turn =turn+1;
    // use to animate the ship,to switch between two images
    countfly= countfly+1;
    if (countfly>=20) {
      countfly=0;
    }
    //play sound
    player.play();
    if ( player.position() == player.length() )
    {
      player.rewind();
      player.play();
    } 
    println(frameRate);
    //  drawgame = ecranjeuon is activ counv would be increase
    ecranjeuon =true;

    //design
    Stars1.dessin();
    BackAsts.affiche();


    // call the display function on all objects
    for (Bonus object : bonus) {
      object.display();
    }

    shipR.display();
    for (Asteroid object : asteroidsB) {
      object.display();
    }
    for (Asteroid object : asteroidsBvitesse) {
      object.display();
    }
    for (Torpedo object : torpedoR) {
      object.display();
    }
    // key control R (use for press/release)
    if (keyUpR) {
      shipR.up();
    }
    if (keyDownR) {
      shipR.down();
    }

    shipB.display();
    for (Asteroid object : asteroidsR) {
      object.display();
    }
    for (Asteroid object : asteroidsRvitesse) {
      object.display();
    }
    for (Torpedo object : torpedoB) {
      object.display();
    }
    // key control B (use for press/release)
    if (keyUpB) {
      shipB.up();
    }
    if (keyDownB) {
      shipB.down();
    }

    checkCollisions();
    //having one category which fill the screen wich the numer of object increase and an other were the speed increase
    if (gameCount >= 100 ) { 
      countNb =  countNb +0.05;
      //win points with time
      currentScoreB += 1;
      currentScoreR += 1;
      asteroidFactory(floor(countNb)); 
      bonusFactory(1);
      asteroidFactoryvitesse(2);
      //reset
      gameCount = 0;
    }
    //have a limite of number of asteroid
    if (countNb >= 5) {
      countNb =5;
    }
    drawScores();

    //  if (gamePause == true)
  } else {
    //stop music
    player.pause();
    //design
    Pauss.affiche();
  }
}

//*************
//Collision Detection
//*************

void checkCollisions() {

  //bonus collision
  for (int i = 0; i < bonus.size(); i++) {
    Bonus object  = bonus.get(i);
    //with the torpedo of blue player
    for (int j = 0; j < torpedoB.size(); j++) {
      Torpedo object2  = torpedoB.get(j);
      if (!object2.display) { // remove torpedo
        torpedoB.remove(object2);
      } else if (object.checkCollision(object2)) {
        bonus.remove(object);
        torpedoB.remove(object2);
        currentScoreB =currentScoreB+5;
      }
    }//with the torpedo of red player
    for (int j = 0; j < torpedoR.size(); j++) {
      Torpedo object2  = torpedoR.get(j);
      if (!object2.display) { // remove torpedo
        torpedoR.remove(object2);
      } else if (object.checkCollision(object2)) {
        bonus.remove(object);
        torpedoR.remove(object2);
        //won points
        currentScoreR =currentScoreR+5;
      }
    }
  }
  //colision Blue ship
  for (int i = 0; i < asteroidsR.size(); i++) {
    Asteroid objectR  = asteroidsR.get(i);

    // check normal red asteroid against blue ship
    if (objectR.checkCollision(shipB)) {
      gameStatus = gameOverB;
    }
    //check the torpedo of the blue ship with normal red asteroid
    for (int j = 0; j < torpedoB.size(); j++) {
      Torpedo object2  = torpedoB.get(j);
      if (!object2.display) { // remove torpedo
        torpedoB.remove(object2);
      } else if (objectR.checkCollision(object2)) {
        asteroidsR.remove(objectR);
        torpedoB.remove(object2);
      }
    }
  }
  //colision Blue ship
  for (int i = 0; i < asteroidsRvitesse.size(); i++) {
    Asteroid objectRvitesse  = asteroidsRvitesse.get(i);

    // check vitesse red asteroid against blue ship
    if (objectRvitesse.checkCollision(shipB)) {
      gameStatus = gameOverB;
    }
    //check the torpedo of the blue ship with vitesse red asteroid
    for (int j = 0; j < torpedoB.size(); j++) {
      Torpedo object2  = torpedoB.get(j);
      if (!object2.display) { // remove torpedo
        torpedoB.remove(object2);
      } else if (objectRvitesse.checkCollision(object2)) {
        asteroidsRvitesse.remove(objectRvitesse);
        torpedoB.remove(object2);
      }
    }
  }//colision Red ship
  for (int i = 0; i < asteroidsB.size(); i++) {
    Asteroid objectB  = asteroidsB.get(i);

    // check normal blue asteroid against red ship
    if (objectB.checkCollision(shipR)) {
      gameStatus = gameOverR;
    }
    //check the torpedo of the red ship with normal blue asteroid
    for (int j = 0; j < torpedoR.size(); j++) {
      Torpedo object2  = torpedoR.get(j);
      if (!object2.display) { // remove torpedo
        torpedoR.remove(object2);
      } else if (objectB.checkCollision(object2)) {
        asteroidsB.remove(objectB);
        torpedoR.remove(object2);
      }
    }
  }//colision Red ship
  for (int i = 0; i < asteroidsBvitesse.size(); i++) {
    Asteroid objectBvitesse  = asteroidsBvitesse.get(i);

    // check vitesse blue asteroid against red ship
    if (objectBvitesse.checkCollision(shipR)) {
      gameStatus = gameOverR;
    }
    //check the torpedo of the red ship with vitesse blue asteroid
    for (int j = 0; j < torpedoR.size(); j++) {
      Torpedo object2  = torpedoR.get(j);
      if (!object2.display) { // remove torpedo
        torpedoR.remove(object2);
      } else if (objectBvitesse.checkCollision(object2)) {
        asteroidsBvitesse.remove(objectBvitesse);
        torpedoR.remove(object2);
        //currentScoreR =currentScoreR+5;
      }
    }
  }
};


//*************
// game events
//*************

void keyPressed() {
  
//command Red player

  if (keyCode == UP && gamePause == false) {
    keyUpR = true;
    move.trigger();
  } 
  if (keyCode == DOWN && gamePause == false) {
    keyDownR = true;
    move.trigger();
  } 
  
  if (keyCode == LEFT && gameStatus == playingGame && shootLimit == false && gamePause == false) {
    shipR.shootLeft();
    shootLimit = true;
    tire.trigger();
  }
  if (keyCode == RIGHT && gameStatus == playingGame && shootLimit == false && gamePause == false) {
    shipR.shootRight();
    shootLimit = true;
    tire.trigger();
  }



//command Blue player

  if (key == 'W'&& gameStatus == playingGame && shootLimit == false && gamePause == false||key == 'w'&& gamePause == false) {
    keyUpB = true;
    move.trigger();
  } 
  if (key == 'S'&& gameStatus == playingGame && shootLimit == false && gamePause == false|| key == 's'&& gamePause == false) {
    keyDownB = true;
    move.trigger();
  } 

  if (key == 'a'&& gameStatus == playingGame && shootLimit == false && gamePause == false|| key =='A' && gameStatus == playingGame && shootLimit == false && gamePause == false) {
    shipB.shootLeft();
    shootLimit = true;
    tire.trigger();
  }
  if (key == 'd' && gameStatus == playingGame && shootLimit == false && gamePause == false|| key =='D' && gameStatus == playingGame && shootLimit == false && gamePause == false) {
    shipB.shootRight();
    shootLimit = true;
    tire.trigger();
  }
  
  

//game command

  if (key == ENTER) {
    if (gameStatus != playingGame) {
      setupGame();
      gameStatus = playingGame;
      move.trigger();
      currentScoreB = 0;
      currentScoreR = 0;
    }
  }
} 

void keyReleased() 
{
// move both player
  if (keyCode == UP || key == 'W'|| key == 'w') {
    keyUpR = false;
    keyUpB = false;
  } 
  if (keyCode == DOWN || key == 'S'|| key == 's') {
    keyDownR = false;
    keyDownB = false;
  } 
  
  //shoot both player
  if (key == 'a' ||key == 'd'|| key == 'A'||key == 'D' && gameStatus == playingGame) {
    shootLimit = false;
  }
  if (keyCode == LEFT||keyCode == RIGHT && gameStatus == playingGame) {
    shootLimit = false;
  }

//pause
  if (key == ' '&& gameStatus == playingGame) {
    move.trigger();
    if (gamePause) {
      gamePause = false;
    } else {
      gamePause = true;
    }
  }
}