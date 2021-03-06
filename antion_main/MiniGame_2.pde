boolean click = false; 
float acidX = 700; 
int good_interval = 1;
int bad_interval = 2;

ArrayList<GoodFood> goodfoods = new ArrayList<GoodFood>();
ArrayList<BadFood> badfoods = new ArrayList<BadFood>();

PImage bg_MiniGame2;
PImage antony_7, acid, apple, donut;

boolean fUck2 = false;

void setupMiniGame2() {
  antony_7 = loadImage("Antony__7.png");
  bg_MiniGame2 = loadImage("game3.png");
  acid = loadImage("acid.png");
  apple = loadImage("apple.png");
  donut = loadImage("donut.png");
  acidX = 700;
  goodTimer = second();
  badTimer = second();
  fUck2 = false;
}

void drawMiniGame2() { 
  if (fUck2 == false) {
    goodTimer = second();
    badTimer = second();
    fUck2 = true;
  }
  background(0);
  imageMode(CORNER);
  image(bg_MiniGame2, 0, 0);
  //antony 
  //fill(255, 255, 255); 
  //ellipse(70, 400, 50, 50);
  antony_7.resize(600, 400);
  image(antony_7, -150, 275);

  //stomach acid 
  //fill(0, 255, 0); 
  //rect(acidX, 0, 1200, 800); 
  image(acid, acidX, 0);

  acidX -= 0.5; 
  if (click == true) { 
    acidX += 14.5;
    click = false;
  } 
  if (acidX < 215) { 
    for (int i = 0; i < goodfoods.size(); i++) {
      goodfoods.remove(i);
    }
    for (int i = 0; i < badfoods.size(); i++) {
      badfoods.remove(i);
    }
    fill(0);
    rect(0, 0, 1200, 800);
    fill(255);
    textSize(50);
    text("YOU LOSE! PRESS R TO RESTART!", 600, 400);
    if (r) {
      setupMiniGame2();
    }
  }

  if (acidX > 1200) { 
    println("YOU WIN!!!");
    // SWITCH SCREEN HERE
    imageMode(CORNER);
    fadeOut = true;
  }

  if (second() - goodTimer > good_interval) {
    goodfoods.add(new GoodFood(random(300, 1100), random(400, 700), 75, 75));
    goodTimer = second();
  }

  if (second() - badTimer > bad_interval) {
    badfoods.add(new BadFood(random(300, 1100), random(400, 700), 75, 75));
    badTimer = second();
  }

  for (int i = 0; i < goodfoods.size(); i++) {
    GoodFood g = goodfoods.get(i);
    g.draw();
  }

  for (int i = 0; i < badfoods.size(); i++) {
    BadFood b = badfoods.get(i);
    b.draw();
  }
  
  // WIN LOSE STATE
   if (acidX < 215) { 
    println("YOU LOST!!!", acidX);
    losingStateBoolean = true;
  }
 
    if (acidX > 1200) { 
    println("YOU WIN!!!");
      // SWITCH SCREEN HERE
      imageMode(CORNER);
      fadeOut = true;
  }
} 

void mouseClicked() { 
  click = true;
  for (int i = 0; i < goodfoods.size(); i++) {
    GoodFood g = goodfoods.get(i);
    if (dist(mouseX, mouseY, g.x, g.y) < 38) {
      goodfoods.remove(i);
      acidX += 50;
    }
  }
  for (int i = 0; i < badfoods.size(); i++) {
    BadFood b = badfoods.get(i);
    if (dist(mouseX, mouseY, b.x, b.y) < 38) {
      badfoods.remove(i);
      acidX -= 75;
    }
  }
}

class GoodFood {
  float x, y, w, h;

  GoodFood(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw() {
    //fill(0,0,255);
    //ellipse(x, y, w,h);
    apple.resize(75, 75);
    image(apple, x-38, y-38);
  }
}

class BadFood {
  float x, y, w, h;

  BadFood(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw() {
    //fill(255,0,0);
    //ellipse(x, y, w,h);
    donut.resize(75, 75);
    image(donut, x-38, y-38);
  }
}
