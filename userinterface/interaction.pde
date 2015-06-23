
void mousePressed() {
  PVector m = new PVector(mouseX, mouseY+50);

  for (int i = 0; i < menuOpts.length; i++) {
    menuOpt mo = menuOpts[i];
    PVector pos = (mo.rightside) ? new PVector(width-menuSize.x, mo.y) : new PVector(0, mo.y);
    boolean hit = pointInRect(m, pos, menuSize);
    if (hit) {
      for (int j = 0; j < menuOpts.length; j++) if (menuOpts[j].rightside == mo.rightside) menuOpts[j].selected = false;
      mo.selected = true;
    }
  }
}

boolean pointInRect(PVector p, PVector pos, PVector size) {
  if (p.x < pos.x) return false;
  if (p.x > pos.x+size.x) return false;
  if (p.y < pos.y) return false;
  if (p.y > pos.y+size.y) return false;
  return true;
}

