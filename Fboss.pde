class FBoss extends FGameObject {

  PImage fire;
  int fireballTimer;
  int fireballInterval;
  int blood = 20;

  FBoss(int x, int y) {
    super();
    setPosition(x, y);
    attachImage(reverseImage(boss));
    bloodbar();
    setName("bosss");
    setRotatable(false);
    fireballTimer = 0;
    fireballInterval = 120;
  }
  
  void act() {
    fireballTimer++;
    if (fireballTimer >= fireballInterval) {
      sendFireball();
      fireballTimer = 0;
    }
    
    if(isTouching("fireba")) {
      blood--;
      step.play();
      step.setGain(1);
      step.rewind();
    }
    if(isTouching("fireba")) {
      damage();
    }
  }

  void sendFireball() {
    fire = loadImage("fire.png");
    fire.resize(32, 32);
    FBox fireball = new FBox(gridSize, gridSize);
    fireball.attachImage(reverseImage(fire));
    fireball.setPosition(getX(), getY());
    fireball.setVelocity(2000, 0);
    fireball.setSensor(true);
    fireball.setName("fireb");
    world.add(fireball);
    if(blood <= 0) {
      world.remove(fireball);
    }
  }

  void damage() {
    blood--;
     if (blood <= 0) {
      world.remove(this);
      player.onoff = false;
    }
  }
  
  
  void bloodbar() {
    float drawWidth = (blood / 10) * 50;
    noFill();
    rect(getX(), getY(), 50, 10);
    fill(lavared);
    rectMode(CORNER);
    rect(getX(), getY(), drawWidth, 10);
    rectMode(CORNER);
  }
}
