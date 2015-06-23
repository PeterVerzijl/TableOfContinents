class statsOpt {
  PVector pos;
  String headline;
  String subtext;

  statsOpt(int _x, int _y, String _headline, String _subtext) {
    pos = new PVector(_x, _y);
    headline = _headline;
    subtext = _subtext;
  }

  void update() {
    drawStatsOpt(pos.x, pos.y, headline, subtext);
  }

  void drawStatsOpt(float x, float y, String headline, String subtext) {
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
}

