class menuOpt {
  int y;
  String text;
  boolean rightside;
  boolean selected;

  menuOpt(int _y, String _text, boolean _rightside, boolean _selected) {
    y = _y;
    text = _text;
    rightside = _rightside;
    selected = _selected;
  }
  
  void update() {
    drawMenuOpt(y, text, rightside, selected);
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
}

