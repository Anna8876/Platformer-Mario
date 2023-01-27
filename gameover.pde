void gameover () {

  if (live == 0) {
    background(#1639bf);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Almost there!", width/2, height/2);
    fill(#f4f6f0);
    textSize(30);
    text("Press space to go back to intro", width/2, height/2+50);
    if (space) {
      reset();
    }
  } else if (live > 0) {
    gif2.show();
    textSize(50);
    fill(#f4f6f0);
    text("Press space to restart", width/2, height/2);
    if (space) {
      reset();
    }
  }
}

void reset() {
  world.clear();
  mode = INTRO;
  theme.pause();
  currentLevel = 1;
  live = 3;
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  setup();
  player.setPosition(100, 0);
  player.setVelocity(0, 0);
}
