PImage bg;
PGraphics buff;
PImage eur;
PImage sam;
PImage nam;
PImage oce;
PImage afr;
PImage asi;
PImage out;

PImage barleft;
PImage barright;
PFont bold36; // Stats head
PFont light18; //Stats sub
PFont light24; // Menu unselected
PVector menuSize;
menuOpt[] menuOpts = new menuOpt[12];

void setup() {
  size(1280, 720);
  bg = loadImage("bg.png");
  buff = createGraphics(width, height);
  barleft = loadImage("barleft.png");
  barright = loadImage("barright.png");

  eur = loadImage("eur.png");
  sam = loadImage("sam.png");
  nam = loadImage("nam.png");
  oce = loadImage("oce.png");
  afr = loadImage("afr.png");
  asi = loadImage("asi.png");
  out = loadImage("outline.png");

  bold36 = createFont("SourceSansPro-Bold", 36);
  light18 = createFont("SourceSansPro-Light", 18);
  light24 = createFont("SourceSansPro-Light", 24);

  menuSize = new PVector(250, 70);

  int y = 250;
  int dy = 70;

  menuOpts[0] = new menuOpt(y+dy*0, "CIGARETTES", false, false);
  menuOpts[1] = new menuOpt(y+dy*1, "OPIATES", false, false);
  menuOpts[2] = new menuOpt(y+dy*2, "AMPHETAMINE", false, true);
  menuOpts[3] = new menuOpt(y+dy*3, "COCAINE", false, false);
  menuOpts[4] = new menuOpt(y+dy*4, "ECSTACY", false, false);
  menuOpts[5] = new menuOpt(y+dy*5, "CANNABIS", false, false);

  menuOpts[6] = new menuOpt(y+dy*0, "SEXLIFE SATISFACTION", true, false);
  menuOpts[7] = new menuOpt(y+dy*1, "UFO SIGHTINGS", true, false);
  menuOpts[8] = new menuOpt(y+dy*2, "HOMICIDE RATE", true, false);
  menuOpts[9] = new menuOpt(y+dy*3, "DRUG RELATED DEATHS", true, false);
  menuOpts[10] = new menuOpt(y+dy*4, "GDP PER CAPITA", true, true);
  menuOpts[11] = new menuOpt(y+dy*5, "OVERWEIGHT", true, false);


  DataLoader dl = new DataLoader();
  dl.load("data.csv");
}

void draw() {
  image(bg, 0, 0);
  drawGears();

  buff.beginDraw();
  buff.image(eur, 0, 0);
  buff.tint(250, 0, 250);
  buff.endDraw();
  image(buff, 0, 0);
  buff.clear();

  buff.beginDraw();
  buff.image(afr, 0, 0);
  buff.tint(0, 250, 250);
  buff.endDraw();
  image(buff, 0, 0);
  buff.clear();

  buff.beginDraw();
  buff.image(nam, 0, 0);
  buff.tint(250, 250, 0);
  buff.endDraw();
  image(buff, 0, 0);
  buff.clear();

  buff.beginDraw();
  buff.image(sam, 0, 0);
  buff.tint(0, 0, 250);
  buff.endDraw();
  image(buff, 0, 0);
  buff.clear();

  buff.beginDraw();
  buff.image(oce, 0, 0);
  buff.tint(0, 250, 0);
  buff.endDraw();
  image(buff, 0, 0);
  buff.clear();

  buff.beginDraw();
  buff.image(asi, 0, 0);
  buff.tint(250, 0, 0);
  buff.endDraw();
  image(buff, 0, 0);
  buff.clear();

  image(out, 0, 0);

  drawStats();
  drawMenu();
  drawInfo();

  noFill();
  stroke(255, 0, 0);
  strokeWeight(1);
  for (int i = 0; i < menuOpts.length; i++) {
    float x = menuOpts[i].rightside ? width-menuSize.x : 0;
    //rect(x, menuOpts[i].y-50, menuSize.x, menuSize.y);
  }
}


void mousePressed() {
  PVector m = new PVector(mouseX, mouseY+50);
<<<<<<< HEAD
  //println(pointInRect(m,p, menuSize));

  for(int i = 0; i < menuOpts.length; i++){
=======

  for (int i = 0; i < menuOpts.length; i++) {
>>>>>>> origin/master
    menuOpt mo = menuOpts[i];
    PVector pos = (mo.rightside) ? new PVector(width-menuSize.x, mo.y) : new PVector(0, mo.y);
    boolean hit = pointInRect(m, pos, menuSize);
    if (hit) {
      for (int j = 0; j < menuOpts.length; j++) if (menuOpts[j].rightside == mo.rightside) menuOpts[j].selected = false;
      mo.selected = true;
    }
  }
<<<<<<< HEAD

=======
>>>>>>> origin/master
}

boolean pointInRect(PVector p, PVector pos, PVector size) {
  if (p.x < pos.x) return false;
  if (p.x > pos.x+size.x) return false;
  if (p.y < pos.y) return false;
  if (p.y > pos.y+size.y) return false;
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

  for (int i = 0; i < menuOpts.length; i++) menuOpts[i].update();
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
