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
  
  void update(){
    drawMenuOpt(y, text, rightside, selected);
  }
  
  
}

