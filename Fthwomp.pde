class FThwomp extends FGameObject {

  boolean isAwake;

  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    attachImage(sleepyImg);
    isAwake = false;
    setStatic(true);
    setDensity(100);
  }


  void act() {
    if (getX() + getWidth() < player.getX()) {
      wakeUp();
    }
    if (isTouching("player")) {
      live --;
      player.setPosition(100, 0);
      lost.play();
      lost.setGain(1);
      lost.rewind();
    }
  }



  void wakeUp() {
    isAwake = true;
    attachImage(angryImg);
    setStatic(false);
  }

  void sleep() {
    isAwake = false;
    attachImage(sleepyImg);
    setStatic(true);
  }
}
