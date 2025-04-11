import processing.sound.*;
SoundFile beep;
PFont f;
int gameState = 0; //0 startscreen, 1 gameplay, 2 being dead
float _speed = -8;
int _jumpCount = 0;
PShape cross;


Zombie s;
Ground[] g;
int nGround = 0;
PImage bg;
Boulder[] b;
int nBoulder = 8;

Landscape[] l1;
int nl1 = 0; 
Landscape[] l2;
int nl2 = 0;
Landscape[] l3;
int nl3 = 0;

void setup()
{
  size(1200,800);
  fullScreen();
  beep = new SoundFile(this,"beep.wav");
  bg = loadImage("bg.jpg");
  f = createFont("FruitJuice-Regular.ttf",100);
  reset();
}

void draw()
{
  if(gameState == 0) startScreen();
  if(gameState == 1) gamePlay();
  if(gameState == 2) deadScreen(); 
}

void keyPressed()
{
  if(gameState == 0) 
  {
    reset();
    gameState = 1;
  }  
  if(gameState == 1) s.jump();
  if(gameState == 2) 
  {
    reset();
    gameState = 1;
  }
}

void reset()
{
  _speed = -8;
  cross = loadShape("cross.svg");
  s = new Zombie();
  s.location.x=(-width/2)+100;
  s.location.y=(height/2)-200;
  String[] files = {"catrun1.svg","catrun2.svg"}; //running
  s.addAnimation(files,10);
  String[] files1 = {"catrunbackwards1.svg","catrunbackwards2.svg"}; //running backwards
  s.addAnimation(files1,10);
  String[] files2 = {"catjumpup.svg"};  //jump up
  s.addAnimation(files2,10);
  String[] files3 = {"catfall1.svg","catfall2.svg"}; //falling down
  s.addAnimation(files3,10);
  String[] files18 = {"catdead.svg"}; //being dead`
  s.addAnimation(files18,10); 
  s.currentAni=0;
  
  nGround = ceil(width/1000.0)+1; //number of ground element is acconted form screen size and ground element width
  g = new Ground[nGround];

  String[] files4 = {"ground1.svg"};
  String[] files5 = {"ground2.svg"};
  String[] files6 = {"ground3.svg"};
  String[] files7 = {"ground4.svg"};
  String[] files8 = {"ground5.svg"};
  String[] files9 = {"ground6.svg"};
  for(int i = 0; i < nGround; i = i + 1)
  {
    g[i] = new Ground();
    g[i].addAnimation(files4,10);
    g[i].addAnimation(files5,10);
    g[i].addAnimation(files6,10);
    g[i].addAnimation(files7,10);
    g[i].addAnimation(files8,10);
    g[i].addAnimation(files9,10);
    g[i].location.x = -(width/2.0)+(g[i].boxx * i);
  }
  
  String[] files10 = {"boulder1.svg"};
  String[] files11 = {"boulder2.svg"};
  String[] files12 = {"boulder3.svg"};
  String[] files13 = {"boulder4.svg"};
  String[] files14 = {"boulder5.svg"};

  b = new Boulder[nBoulder];
  for(int i = 0; i < nBoulder; i = i + 1)
  {
    b[i] = new Boulder();
    b[i].addAnimation(files10,10);
    b[i].addAnimation(files11,10);
    b[i].addAnimation(files12,10);
    b[i].addAnimation(files13,10);
    b[i].addAnimation(files14,10);
    b[i].location.x = (width/2.0)+random(10,4000);
    b[i].adjustReg();
  }
  
  nl1 = ceil(width/1000.0)+1;
  l1 = new Landscape[nl1];
  String[] files15 = {"cloud1.svg"};
  for(int i = 0; i < nl1; i = i + 1)
  {
    l1[i] = new Landscape();
    l1[i].location.x = (-width/2.0)+(i*1000.0);
    l1[i].addAnimation(files15,10);
    l1[i].randomPlacement=true;
    l1[i].slowdown = 0.2;
  }
  
  nl2 = ceil(width/1000.0)+1;
  l2 = new Landscape[nl2];
  String[] files16 = {"cloud2.svg"};
  String[] files17 = {"cloud3.svg"};
  for(int i = 0; i < nl2; i = i + 1)
  {
    l2[i] = new Landscape();
    l2[i].location.x = (-width/2.0)+(i*1000.0);
    l2[i].location.y = (-height/2.0)+50;
    l2[i].velocity.x = -0.5;
    l2[i].addAnimation(files16,10);
    l2[i].addAnimation(files17,10);
    l2[i].slowdown = 0.1;
  }
  nl3 = ceil(width/1000.0)+1;
  l3 = new Landscape[nl3];
  for(int i = 0; i < nl3; i = i + 1)
  {
    l3[i] = new Landscape();
    l3[i].location.x = (-width/2.0)+(i*1000.0);
    l3[i].location.y = (-height/2.0)-50;
    l3[i].velocity.x = -0.7;
    l3[i].addAnimation(files17,10);
    l3[i].addAnimation(files16,10);
    l3[i].slowdown = 0.12;
  }
}

void startScreen()
{
  gamePlay();
  s.location.x = 10000; 
  noStroke();
  fill(224, 194, 242);
  textAlign(CENTER,CENTER);
  textFont(f);
  textSize(100);
  text("Zoomies",0,-30);
  textSize(30);
  text("Press any key to start!",0,30);
}

void deadScreen()
{
  s.isDead = true;
  s.acceleration.y=-0.01;
  _speed = _speed*0.99;
  gamePlay();
  fill(224, 194, 242);
  textAlign(CENTER,CENTER);
  textFont(f);
  textSize(100);
  text("R.I.P.",0,0);
  textSize(30);
  text("Oh no! Press any key to resurrect kitty! ",0,60);
  /*noStroke();
  fill(0);
  rect(0,0,width,height);
  fill(255);
  textAlign(CENTER,CENTER);
  text("RIP. Press ANY key to resurrection",width/2,height/2);*/
}

void gamePlay()
{
  noStroke();
  fill(color(247,179,178));
  rect(0,0,width,height);
  image(bg,0,0);
  translate(width/2,height/2);
  for(int i = 0; i < nl1; i = i + 1)
  {
    l1[i].update();
    l1[i].check();
    l1[i].display();
  }
  
  
  
  for(int i = 0; i < nl3; i = i + 1)
  {
    l3[i].update();
    l3[i].check();
    l3[i].display();
  }
  
  for(int i = 0; i < nGround; i = i + 1)
  {
    g[i].update();
    g[i].check();
    g[i].display();
  }
  
  for(int i = 0; i < nBoulder; i = i + 1)
  {
    b[i].update();
    b[i].check();
    b[i].display();
  }
  
  s.update();
  s.check();
  s.display();
  for(int i = 0; i < nl2; i = i + 1)
  {
    l2[i].update();
    l2[i].check();
    l2[i].display();
  }
  hud();
}

void hud()
{
  if(_jumpCount > 0)
  {
    shape(cross,-cross.width/2,-height/2);
    textAlign(CENTER,CENTER);
    fill(224, 194, 242);
    textSize(30);
    pushMatrix();
    translate(0,(-height/2)+80);
    rotate(radians(-18));
    text(_jumpCount,0,0);
    popMatrix();
  }
}
