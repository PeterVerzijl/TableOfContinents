PImage bg;
PImage eur, sam, nam, oce, afr, asi;
color eurc, samc, namc, ocec, afrc, asic;
PImage out;
PImage barleft;
PImage barright;
PFont bold36; // Stats head
PFont light18; //Stats sub
PFont light24; // Menu unselected
PVector menuSize;

menuOpt[] menuOpts = new menuOpt[12];
statsOpt[] statsOpts = new statsOpt[7];
DataLoader dl = new DataLoader();

// Arduino
ArduinoInterface arduino;

// Continents
// Six continents: europe, south america, north america, africa, asia.
String[] continentNames = {"Europe", "South America", "North America", "Africa", "Asia", "Ociania"};
Continent[] continents = new Continent[6];

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

  eurc = color(250, 0, 0);
  samc = color(0, 250, 0);
  namc = color(0, 0, 250);
  ocec = color(250, 250, 0);
  afrc = color(250, 0, 250);
  asic = color(0, 250, 250);

  out = loadImage("outline.png");

  bold36 = loadFont("SourceSansPro-Bold-36.vlw");
  light18 = loadFont("SourceSansPro-Light-18.vlw");
  light24 = loadFont("SourceSansPro-Light-24.vlw");

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


  statsOpts[0] = new statsOpt(555, 325, "12.2%", "EUROPE");
  statsOpts[1] = new statsOpt(570, 480, "64.8%", "AFRICA");
  statsOpts[2] = new statsOpt(790, 330, "23.5%", "ASIA");
  statsOpts[3] = new statsOpt(385, 520, "34.0%", "SOUTH AMERICA");
  statsOpts[4] = new statsOpt(350, 315, "14.2%", "NORTH AMERICA");
  statsOpts[5] = new statsOpt(855, 560, "47.1%", "OCEANIA");
  statsOpts[6] = new statsOpt(0, 100, "DRUG USE", "PER CAPITA");


  // Fill continents array with continents
  DataPoint[] points = dl.load("data.csv");
  for(int i = 0; i < continents.length; i++)
  {
      continents[i] = new Continent(
        continentNames[i], i + 1, i + 1, 
        points[i]);
  }

  // Initialize arduino
  arduino = new ArduinoInterface(this);
}

void draw() {
  image(bg, 0, 0);
  drawGears();

  drawTintedImage(asi, asic);
  drawTintedImage(afr, afrc);
  drawTintedImage(eur, eurc);
  drawTintedImage(nam, namc);
  drawTintedImage(sam, samc);
  drawTintedImage(oce, ocec);

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
  text(headline, 10, 5);

  textSize(18);
  textFont(light18);
  textAlign(LEFT, TOP);
  text(subtext, 10, 35);

  popMatrix();
  popStyle();
}

void serialEvent(Serial port)
{
  arduino.serialEvent(port);
}
