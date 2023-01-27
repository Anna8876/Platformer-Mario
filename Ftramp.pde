class Ftramp extends FGameObject {
  Ftramp(float x, float y) {
    super();
    setPosition(x, y);
    setName("trampl");
    attachImage(tramp);
    setStatic(true);
  }
  void act() {
    if (isTouching("player")) {
      player.setVelocity(player.getVelocityX(), -1000);
      step.play();
      step.setGain(1);
      step.rewind();
    }
  }
}

class Fwhat extends FGameObject {
  Fwhat(float x, float y) {
    super();
    setPosition(x, y);
    setName("whatbox");
    attachImage(what);
    setStatic(true);
  }
  void act() {
    if (isTouching("player")) {
     world.remove(this);
    }
  }
}
