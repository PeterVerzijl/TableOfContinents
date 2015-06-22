PImage bg;
PImage map;
PImage barleft;
PImage barright;
PFont bold36; // Stats head
PFont light18; //Stats sub
PFont light24; // Menu unselected
PVector p, s;

void setup() {
  size(1280, 720);
  bg = loadImage("bg.png");
  map = loadImage("map.png");
  barleft = loadImage("barleft.png");
  barright = loadImage("barright.png");

  bold36 = createFont("SourceSansPro-Bold", 36);
  light18 = createFont("SourceSansPro-Light", 18);
  light24 = createFont("SourceSansPro-Light", 24);
  
  p = new PVector(width/2, height/2);
  s = new PVector(200, 200);
}



void draw() {
  image(bg, 0, 0);
  drawGears();
  image(map, 0, 0);
  drawStats();
  drawMenu();
  drawInfo();
  noFill();
  stroke(255,0, 0);
  strokeWeight(1);
  rect(p.x, p.y, s.x, s.y);
}

void mousePressed(){
  PVector m = new PVector(mouseX, mouseY);
  println(pointInRect(m,p,s));
}

boolean pointInRect(PVector p, PVector pos, PVector size){
  if(p.x < pos.x) return false;
  if(p.x > pos.x+size.x) return false;
  if(p.y < pos.y) return false;
  if(p.y > pos.y+size.y) return false;
  return true;
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
  drawStatsOpt(0, 100, "DRUG USE", "PER CAPITA");

  int y = 250;
  int dy = 70;

  drawMenuOpt(y+dy*0, "CIGARETTES", false, false);
  drawMenuOpt(y+dy*1, "AMPHETAMINE", false, false);
  drawMenuOpt(y+dy*2, "OPIATES", false, true);
  drawMenuOpt(y+dy*3, "COCAINE", false, false);
  drawMenuOpt(y+dy*4, "ECSTACY", false, false);
  drawMenuOpt(y+dy*5, "CANNABIS", false, false);

  drawMenuOpt(y+dy*0, "SEXLIFE SATISFACTION", true, false);
  drawMenuOpt(y+dy*1, "UFO SIGHTINGS", true, false);
  drawMenuOpt(y+dy*2, "HOMICIDE RATE", true, false);
  drawMenuOpt(y+dy*3, "DRUG RELATED DEATHS", true, false);
  drawMenuOpt(y+dy*4, "GDP PER CAPITA", true, true);
  drawMenuOpt(y+dy*5, "OVERWEIGHT", true, false);
}

void drawMenuOpt(int y, String text, boolean rightside, boolean selected) {
  int x = rightside ? width - 216 : 0;
  float tx = rightside ? width - 10 : 10;
  PImage bar = rightside ? barright : barleft;
  int halign = rightside ? RIGHT : LEFT;

  if (selected && rightside) text = "» " + text;
  else if (selected && !rightside) text = text + " «";

  if (selected) {
    textSize(36);
    textFont(bold36);
    fill(255, sin(millis()/100.0)*50+200);
  } else {
    textSize(24);
    textFont(light24);
    fill(255, 255);
  }

  textAlign(halign, BOTTOM);
  text(text, tx, y);

  image(bar, x, y-12);
}

void drawStats() {
  drawStatsOpt(555, 325, "12.2%", "EUROPE");
  drawStatsOpt(570, 480, "64.8%", "AFRICA");
  drawStatsOpt(790, 330, "23.5%", "ASIA");
  drawStatsOpt(385, 520, "34.0%", "SOUTH AMERICA");
  drawStatsOpt(350, 315, "14.2%", "NORTH AMERICA");
  drawStatsOpt(855, 560, "47.1%", "OCEANIAN");
}

void drawStatsOpt(int x, int y, String headline, String subtext) {
  pushStyle();
  pushMatrix();
  translate(x, y);
  textSize(36);
  float headlineWidth = textWidth(headline);
  textSize(18);
  float subtextWidth = textWidth(subtext);
  float boxWidth = max(headlineWidth, subtextWidth) +20;

  noStroke();
  fill(0, 0, 0, 255*.3);
  rect(0, 0, boxWidth, 55);

  fill(255);
  rect(0, 0, 5, 55);

  textSize(36);
  textFont(bold36);
  textAlign(LEFT, TOP);
  text(headline, 10, -5);

  textSize(18);
  textFont(light18);
  textAlign(LEFT, TOP);
  text(subtext, 10, 30);

  popMatrix();
  popStyle();
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

