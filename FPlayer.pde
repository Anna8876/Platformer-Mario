class FPlayer extends FGameObject {

  int frame, direction, lives;
  int timer = 0;
  int interval;
  PImage fi;
  boolean onoff = false;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(100, 0);
    setName("player");
    setRotatable(false);
    setFillColor(lavared);
  }

  void act() {
    handleInput();
    collision();
    animate();
    if (onoff == true) {
       FireballAbility();
    }
  }

  void handleInput() {
    //if (akey) player.addImpulse(-40, 0);
    //if (dkey) player.addImpulse(40, 0);
    float vy=getVelocityY();
    float vx=getVelocityX();
    if (abs(vy) < 0.1) action = idle;

    if (akey) {
      action=run;
      setVelocity(-200, vy);
      direction=L;
    }
    if (dkey) {
      action=run;
      setVelocity(200, vy);
      direction=R;
    }
    ArrayList<FContact> contacts = player.getContacts();
    if (wkey && contacts.size() > 0) player.setVelocity(player.getVelocityX(), -400);
    if (abs(vy) > 0.1) action=jump;
    if (skey)setVelocity(vx, 100);
  }

  void collision() {
    if (isTouching("spike")) {
      setPosition(100, 0);
      setVelocity(0, 0);
      live-- ;
      lost.play();
      lost.setGain(1);
      lost.rewind();
    }
    if (isTouching("flagg")) {
      step.play();
      step.setGain(1);
      step.rewind();
      currentLevel = 2;
      loadWorld();
      text("Level: 2", 35, 130);
      player.setPosition(100, 0);
      player.setVelocity(0, 0);
    }
    if (isTouching("hamm")) {
      lost.play();
      lost.setGain(1);
      lost.rewind();
      lives--;
    }
    if (isTouching("prince")) {
      mode = GAMEOVER;
    }
    if (isTouching("hamm")) {
      live-- ;
      player.setPosition(100, 0);
      player.setVelocity(0, 0);
      lost.play();
      lost.setGain(1);
      lost.rewind();
    }
    if (isTouching("fireb")) {
      live-- ;
      player.setPosition(100, 0);
      player.setVelocity(0, 0);
      lost.play();
      lost.setGain(1);
      lost.rewind();
    }
    if (isTouching("whatbox")) {
      live = 3;
      timer ++;
      interval = 60;
      step.play();
      step.setGain(1);
      step.rewind();
      onoff = true;
    }
  }


  void animate() {
    if (frame >= action.length) frame=0;
    if (frameCount%5==0) {
      attachImage(action[frame]);
      if (direction == R) attachImage(action[frame]);
      if (direction==L)  attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void FireballAbility() {
    timer++;
    if (timer >= interval) {
    sent();
    timer = 0;
    }
  }

  void sent() {
    fi = loadImage("harm.png");
    fi.resize(32, 32);
    FBox fir = new FBox(gridSize, gridSize);
    fir.attachImage(fire);
    fir.setPosition(getX(), getY());
    if (direction == L) fir.setVelocity(-2000, 0);
    if (direction==R)  fir.setVelocity(2000, 0);
    fir.setSensor(true);
    fir.setName("fireba");
    world.add(fir);
  }
}
