
void updateData(menuOpt mo) {
  for (int j = 0; j < menuOpts.length; j++) if (menuOpts[j].rightside == mo.rightside) menuOpts[j].selected = false;
  mo.selected = true;

  if(!mo.rightside)
    for (int i = 0; i < dl.dataPoints.length; i++)
      for (int j = 0; j < statsOpts.length; j++)
        if (statsOpts[j].subtext.toLowerCase().equals(dl.dataPoints[i].continentName.toLowerCase())){
          if(mo.text.equals("CIGARETTES")) statsOpts[j].headline = str(dl.dataPoints[i].cigarettes) + "%";
          else if(mo.text.equals("OPIATES")) statsOpts[j].headline = str(dl.dataPoints[i].opiates) + "%";
          else if(mo.text.equals("AMPHETAMINE")) statsOpts[j].headline = str(dl.dataPoints[i].amphetamine) + "%";
          else if(mo.text.equals("COCAINE")) statsOpts[j].headline = str(dl.dataPoints[i].cocaine) + "%";
          else if(mo.text.equals("ECSTACY")) statsOpts[j].headline = str(dl.dataPoints[i].ecstacy) + "%";
          else if(mo.text.equals("CANNABIS")) statsOpts[j].headline = str(dl.dataPoints[i].cannabis) + "%";
        }
        
   
  if(mo.rightside)
    for (int i = 0; i < dl.dataPoints.length; i++){
      println(dl.dataPoints[i].continentName);
    }
    
         
        

  /*
   menuOpts[6] = new menuOpt(y+dy*0, "SEXLIFE SATISFACTION", true, false);
   menuOpts[7] = new menuOpt(y+dy*1, "UFO SIGHTINGS", true, false);
   menuOpts[8] = new menuOpt(y+dy*2, "HOMICIDE RATE", true, false);
   menuOpts[9] = new menuOpt(y+dy*3, "DRUG RELATED DEATHS", true, false);
   menuOpts[10] = new menuOpt(y+dy*4, "GDP PER CAPITA", true, true);
   menuOpts[11] = new menuOpt(y+dy*5, "OVERWEIGHT", true, false);
   */

  for (int i = 0; i < dl.dataPoints.length; i++) {
    //println(dl.dataPoints[i].continentName, dl.dataPoints[i].population, dl.dataPoints[i].UFOSightings, dl.dataPoints[i].canabis);
  }
}

void mousePressed() {
  PVector m = new PVector(mouseX, mouseY+50);

  for (int i = 0; i < menuOpts.length; i++) {
    menuOpt mo = menuOpts[i];
    PVector pos = (mo.rightside) ? new PVector(width-menuSize.x, mo.y) : new PVector(0, mo.y);
    boolean hit = pointInRect(m, pos, menuSize);
    if (hit) {
      updateData(mo);
      break;
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

