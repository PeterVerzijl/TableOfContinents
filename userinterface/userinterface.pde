PImage bg;
PGraphics buff;
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

  dl.load("data.csv");
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

  //drawDebugOutline();
}

