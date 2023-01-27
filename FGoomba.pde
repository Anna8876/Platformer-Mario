class FGoomba extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
    attachImage(goomba[frameCount%2]);
  }

  void act() {
    animate();
    move();
    collide();
  }

  void animate() {
    if (frame>=goomba.length) frame=0;
    if (frameCount % 10 == 0) {
      if (direction==R) attachImage(goomba[frame]);
      if (direction==L)  attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }


  void collide() {
    if (isTouching("wall")) {
      direction = direction*-1;
      speed = speed*-1;
      setPosition(getX()+ speed/25, getY());
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
        lost.play();
        lost.setGain(1);
        lost.rewind();
        live-- ;
        player.setPosition(100, 0);
      }
    }
  }

  void move() {
    float vy=getVelocityY();
    setVelocity(speed, vy);
  }
}
