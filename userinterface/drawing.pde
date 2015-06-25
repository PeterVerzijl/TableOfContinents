
PGraphics buff;
void drawTintedImage(PImage img, color col){
  buff.beginDraw();
  buff.image(img, 0, 0);
  buff.tint(col);
  buff.endDraw();
  image(buff, 0, 0);
  buff.clear();
}

void drawScale(){
  image(scale, 1000, 100);
  
  textFont(light24);
  
  String legend = str(scaleMin) + " — " + str(scaleMax);
  
  float tw = textWidth(legend);
  
  
  fill(0, 255*.5);
  noStroke();
  rect(1100-tw/2-10, 150-10, tw+20, 25+20);
  
  textAlign(CENTER, TOP);
  fill(255);
  
  text(legend, 1100, 150);
  
}

void drawDebugOutline() {
  noFill();
  stroke(255, 0, 0);
  strokeWeight(1);
  for (int i = 0; i < menuOpts.length; i++) {
    float x = menuOpts[i].rightside ? width-menuSize.x : 0;
    rect(x, menuOpts[i].y-50, menuSize.x, menuSize.y);
  }
}

void drawGears() {
  dashedCircle(width/2, height/2+70, 300, 6, 4, 10, millis()/10000.0);
  strokeWeight(5);
  stroke(255, 20);
  noFill();
  ellipse(width/2, height/2+70, 280*2, 280*2);
  dashedCircle(width/2, height/2+70, 240, 10, 10, 20, -millis()/20000.0);
}

void drawInfo() {
  fill(0, 100);
  noStroke();
  rect(410, 60, 460, 90);
  textAlign(CENTER);
  textSize(24);
  textFont(light24);
  textLeading(24);
  fill(255);
  text("CHOOSE A DRUG ON THE LEFT AND\nA POSSIBLE CORRELATION ON THE RIGHT", width/2, 100);
}

void drawMenu() {
  for (int i = 0; i < menuOpts.length; i++) menuOpts[i].update();
}

void drawStats() {
  for (int i = 0; i < statsOpts.length; i++) statsOpts[i].update();
}




/* Method of dashing circle abbreviated from */
/* http://www.openprocessing.org/sketch/28215 */

void dashedCircle(int x, int y, float radius, int dashWidth, int dashSpacing, int weight, float rot) {
  pushStyle();
  pushMatrix();
  translate(x, y);
  rotate(rot);
  noFill();
  stroke(255, 20);
  strokeWeight(weight);
  strokeCap(SQUARE);

  int steps = 200;
  int dashPeriod = dashWidth + dashSpacing;
  boolean lastDashed = false;
  for (int i = 0; i < steps; i++) {
    boolean curDashed = (i % dashPeriod) < dashWidth;
    if (curDashed && !lastDashed) beginShape();

    if (!curDashed && lastDashed) endShape();

    if (curDashed) {
      float theta = map(i, 0, steps, 0, TWO_PI);
      vertex(cos(theta) * radius, sin(theta) * radius);
    }
    lastDashed = curDashed;
  }
  if (lastDashed) endShape();

  popMatrix();
  popStyle();
}

