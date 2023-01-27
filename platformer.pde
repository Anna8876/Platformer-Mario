import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;
FWorld world;

color ground = #000000;
color lavared = #ff0000;
color icyblue = #0000ff;
color treetrunk = #FFFF00;
color tree = #95ff00;
color sky = #2786FF;
color spikegrey = #ff00ff;
color trampoline = #00ffe6;
color bridgeorange = #ff6200;
color gumbayellow = #fff200;
color grey = #757575;
color flagcolor = #ffa3b1;
color thwcolor = #b700ff;
color brocolor = #6f3198;
color iviwall =#00ffc8;
color princess = #ff00e1;
color bosscolor = #00ff91;
color whatcolor = #ffaa00;

PImage map, ice, stone, treeTrunk, treeL, treeR, treeIntersect, treeT, spike, life, losslive;
PImage bridge, tramp, flag, sleepyImg, angryImg, hammer, prin, boss, fire, what;
int gridSize = 32;
float zoom = 1;
boolean wkey, akey, skey, dkey, upkey, downkey, rkey, lkey, space;
FPlayer player;
int lives = 3;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

PImage level1Image;
PImage level2Image;
int currentLevel = 1;

//main character action
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[]goomba = new PImage[2];
PImage[]bro = new PImage[2];
PImage[] lava = new PImage[6];
int f;
int live = 3;

final int INTRO    = 0;
final int PLAY     = 1;
final int GAMEOVER = 3;
int mode = INTRO;

Gif gif, gif2;
PFont milky;
Minim minim;
AudioPlayer theme, step, lost;


void setup() {
  Fisica.init(this);
  size(600, 600);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  loadImages();
  loadWorld();
  loadPlayer();
}

void loadImages() {
  level1Image = loadImage("pixil-frame-5.png");
  level2Image = loadImage("pixil-frame-6.png");

  ice = loadImage("blueBlock.png");
  ice.resize(32, 32);
  treeTrunk = loadImage("tree_trunk.png");
  stone = loadImage("brick.png");
  treeL = loadImage("treetop_w.png");
  treeR = loadImage("treetop_e.png");
  treeIntersect = loadImage("tree_intersect.png");
  treeT = loadImage("treetop_center.png");
  spike = loadImage("spike.png");
  life = loadImage("live.png");
  losslive = loadImage("losslive.png");
  bridge = loadImage("bridge_center.png");
  tramp = loadImage("trampoline.png");
  gif = new Gif("frame_", "_delay-0.07s.gif", 25, 4, 0, height/3, width, height*2/3);
  gif2 = new Gif("frame_", "_delay-0.1s.gif", 28, 4, 0, 0, width, height);
  milky= createFont ("Milky.otf", 200);
  flag = loadImage("flag.png");
  flag.resize(32, 32);
  sleepyImg = loadImage ("thwomp0.png");
  angryImg = loadImage ("thwomp1.png");
  hammer = loadImage("hammer.png");
  prin = loadImage ("girl.png");
  prin.resize(32, 32);
  minim = new Minim(this);
  theme = minim.loadFile("theme.mp3");
  step = minim.loadFile("step.mp3");
  lost = minim.loadFile("lost.wav");
  boss = loadImage("boss.png");
  boss.resize(96, 96);
  fire = loadImage("fire.png");
  fire.resize(32, 32);
  what = loadImage("what.png");
  what.resize(32, 32);

  //main character action
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run =new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");
  action = idle;

  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  bro = new PImage[2];
  bro[0] = loadImage("hammerbro0.png");
  bro[0].resize(gridSize, gridSize);
  bro[1] = loadImage("hammerbro1.png");
  bro[1].resize(gridSize, gridSize);

  lava[0] = loadImage( "lava1.png" );
  lava[1] = loadImage( "lava2.png" );
  lava[2] = loadImage( "lava3.png" );
  lava[3] = loadImage( "lava4.png" );
  lava[4] = loadImage( "lava5.png" );
  lava[5]=loadImage("lava0.png");
}


void loadWorld() {
  world = new FWorld(-2000, -2000, 2000, 2000);

  if (currentLevel == 1) {
    world.setGravity(0, 900);
    loadLevel(level1Image);
  } else if (currentLevel == 2) {
    world.setGravity(0, 900);
    loadLevel(level2Image);
    loadPlayer();
  }
}


void loadLevel(PImage levelImage) {
  for (int y = 0; y < levelImage.height; y++) {
    for (int x = 0; x < levelImage.width; x++) {
      color c = levelImage.get(x, y); // color  of current pixel
      color s = levelImage.get(x, y+1); //color below current pixel
      color w = levelImage.get(x-1, y);
      color e = levelImage.get(x+1, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == ground) {
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      }
      if (c == grey) {
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      }
      if (c == icyblue) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      }
      if ( c == treetrunk) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("treetrunk");
        world.add(b);
      }
      if (c == iviwall) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("wall");
        world.add(b);
      }
      if ( c == tree && w != tree) { // treel
        b.attachImage(treeL);
        b.setFriction(5);
        b.setName("treetop");
        world.add(b);
      }
      if ( c == tree && e != tree) { // treer
        b.attachImage(treeR);
        b.setFriction(5);
        b.setName("treetop");
        world.add(b);
      }
      if ( c == tree && s == treetrunk) { //intersect
        b.attachImage(treeIntersect);
        b.setFriction(5);
        b.setName("treetop");
        world.add(b);
      }
      if ( c == tree && w == tree && e == tree && s != treetrunk) {  //middle
        b.attachImage(treeT);
        b.setFriction(5);
        b.setName("treetop");
        world.add(b);
      }
      if (c == spikegrey) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      }
      if (c == bridgeorange) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      }
      if (c==gumbayellow) {
        FGoomba gmb=new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      }
      if (c==lavared) {
        FLava br=new FLava(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      }
      if (c == trampoline) {
        Ftramp tra = new Ftramp(x*gridSize, y*gridSize);
        terrain.add(tra);
        world.add(tra);
      }
      if (c == flagcolor) {
        b.attachImage(flag);
        b.setName("flagg");
        world.add(b);
        b.setGroupIndex(2);
      }
      if (c == thwcolor) {
        FThwomp thw = new FThwomp(x*gridSize, y*gridSize);
        terrain.add(thw);
        world.add(thw);
      }
      if (c == brocolor) {
        FHammerBro broo = new FHammerBro(x*gridSize, y*gridSize);
        terrain.add(broo);
        world.add(broo);
      }
      if (c == princess) {
        b.attachImage(prin);
        b.setName("prince");
        world.add(b);
      }
      if(c == bosscolor) {
        FBoss bos = new FBoss(x*gridSize, y*gridSize);
        terrain.add(bos);
        world.add(bos);
      }
      if(c == whatcolor) {
        Fwhat wh = new Fwhat(x*gridSize, y*gridSize);
        terrain.add(wh);
        world.add(wh);
      }
    }
  }
}



void loadPlayer() {
  player = new FPlayer();
  player.setGroupIndex(1);
  world.add(player);
}

void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == PLAY) {
    play();
  } else if (mode == GAMEOVER) {
    gameover();
  }
}
