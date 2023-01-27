int n = 0;

void intro() {
  theme.play();
  theme.setGain(0.1);
  
  background (#e3ad6b);
  fill(#fc233a);
  textFont(milky);
  textAlign(CENTER, CENTER);
  gif.show();
  
  textSize(50);
  fill(#f4f6f0);
  text("Press space to start", width/2, height/2-50);
  textSize(150);
  
  n = n + 1;
  if (n < 25) {
    fill(#fc233a);
    text("MARIO", width/2, 100);
  } else if (n < 50) {
    fill(#1639bf);
    text("MARIO", width/2, 100);
  }
  if (n == 50) {
    n = 0;
  }
  
  if (space) {
    mode = PLAY;
  }
  
}
