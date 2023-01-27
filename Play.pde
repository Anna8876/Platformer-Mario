void play () {
  background(sky);
  drawWorld();
  actWorld();
  showlife();
  mario();
}

void actWorld() {
  player.act();

  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.draw();
  world.step();
  popMatrix();
}

void showlife() {
  textFont(milky);
  textSize(50);
  fill(#fc233a);
  if (currentLevel == 1) {
    text("Level: 1", 100, 120);
  } else if (currentLevel == 2) {
    text("Level: 2", 100, 120);
  }
  if (live == 3) {
    image (life, 30, 30, 50, 50);
    image (life, 85, 30, 50, 50);
    image (life, 140, 30, 50, 50);
  } else if (live == 2) {
    image (life, 30, 30, 50, 50);
    image (life, 85, 30, 50, 50);
    image (losslive, 140, 30, 50, 50);
  } else if (live == 1) {
    image (life, 30, 30, 50, 50);
    image (losslive, 85, 30, 50, 50);
    image (losslive, 140, 30, 50, 50);
  } else if (live == 0) {
    image (losslive, 30, 30, 50, 50);
    image (losslive, 85, 30, 50, 50);
    image (losslive, 140, 30, 50, 50);
  }
}

void mario () {
  if (live <= 0) {
    mode = GAMEOVER;
  }
}
