class FHammerBro extends FGameObject {

  int direction;
  int speed = 50;
  int frame = 0;

  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("bro");
    setRotatable(false);
    attachImage(bro[frameCount%2]);
    direction = R;
  }

  void act() {
    animate();
    move();
    collide();
  }

  void animate() {
    if (frame>= bro.length) frame=0;
    if (frameCount % 10 == 0) {
      if (direction == R) attachImage(bro[frame]);
      if (direction == L)  attachImage(reverseImage(bro[frame]));
      frame++;
    }
  }



  void collide() {
    if (isTouching("wall")) {
      throwHammer();
      direction = direction*-1;
      setPosition(getX()+ direction*5, getY());
    }

    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        step.play();
        step.setGain(1);
        step.rewind();
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -500);
      } else {
        live-- ;
        lost.play();
        lost.setGain(1);
        lost.rewind();
        player.setPosition(100, 0);
      }
    }
  }

  void move() {
    float vy=getVelocityY();
    setVelocity(direction*speed, vy);
  }

  void throwHammer() {
    FBox ham = new FBox(gridSize, gridSize);
    ham.attachImage(hammer);
    ham.setPosition(getX(), getY());
    ham.setVelocity(random(-500, 500), -500);
    ham.setAngularVelocity(random(-500, 500));
    ham.setName("hamm");
    ham.setSensor(true);
    world.add(ham);
  }
}
