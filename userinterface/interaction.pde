void updateData(menuOpt mo) {
  for (int j = 0; j < menuOpts.length; j++) if (menuOpts[j].rightside == mo.rightside) menuOpts[j].selected = false;
  mo.selected = true;

  if (!mo.rightside) {
    float[] data = new float[continents.length];
    for (int i = 0; i < continents.length; i++) {
      for (int j = 0; j < statsOpts.length; j++) {
        if (statsOpts[j].subtext.toLowerCase().equals(continents[i].dataPoint.continentName.toLowerCase())) {
          if (mo.text.equals("CIGARETTES")) { 
            statsOpts[j].headline = str(continents[i].dataPoint.cigarettes) + "%"; 
            data[i] = continents[i].dataPoint.cigarettes;
          } else if (mo.text.equals("OPIATES")) { 
            statsOpts[j].headline = str(continents[i].dataPoint.opiates) + "%";  
            data[i] = continents[i].dataPoint.opiates;
          } else if (mo.text.equals("AMPHETAMINE")) { 
            statsOpts[j].headline = str(continents[i].dataPoint.amphetamine) + "%"; 
            data[i] = continents[i].dataPoint.amphetamine;
          } else if (mo.text.equals("COCAINE")) { 
            statsOpts[j].headline = str(continents[i].dataPoint.cocaine) + "%"; 
            data[i] = continents[i].dataPoint.cocaine;
          } else if (mo.text.equals("ECSTACY")) { 
            statsOpts[j].headline = str(continents[i].dataPoint.ecstacy) + "%"; 
            data[i] = continents[i].dataPoint.ecstacy;
          } else if (mo.text.equals("CANNABIS")) { 
            statsOpts[j].headline = str(continents[i].dataPoint.cannabis) + "%"; 
            data[i] = continents[i].dataPoint.cannabis;
          }
        }
      }
    }
    arduino.SetDrugType(data);
  }


  if (mo.rightside) {
    for (int i = 0; i < continents.length; i++) {
      if (mo.text.equals("SEXLIFE SATISFACTION")) {
        color c1 = color(#fff746);
        color c2 = color(#ff0201);
        float[] stats = new float[6];
        for (int j = 0; j < continents.length; j++) stats[j] = continents[j].dataPoint.sexLifeSatisfaction;
        float max = max(stats);
        float min = min(stats);

        asic = lerpColor(c1, c2, norm(stats[4], min, max));//4
        eurc = lerpColor(c1, c2, norm(stats[3], min, max));//3
        samc = lerpColor(c1, c2, norm(stats[5], min, max));//5
        namc = lerpColor(c1, c2, norm(stats[2], min, max));//2
        afrc = lerpColor(c1, c2, norm(stats[1], min, max));//1
        ocec = lerpColor(c1, c2, norm(stats[0], min, max));//0

        arduino.SetColors(new color[] {
          asic, eurc, samc, namc, afrc, ocec
        }
        );

        return;
      }

      if (mo.text.equals("UFO SIGHTINGS")) {
        color c1 = color(#ffffff);
        color c2 = color(#9845ff);
        float[] stats = new float[6];
        for (int j = 0; j < continents.length; j++) stats[j] = continents[j].dataPoint.UFOSightings;
        float max = max(stats);
        float min = min(stats);

        asic = lerpColor(c1, c2, norm(stats[4], min, max));//4
        eurc = lerpColor(c1, c2, norm(stats[3], min, max));//3
        samc = lerpColor(c1, c2, norm(stats[5], min, max));//5
        namc = lerpColor(c1, c2, norm(stats[2], min, max));//2
        afrc = lerpColor(c1, c2, norm(stats[1], min, max));//1
        ocec = lerpColor(c1, c2, norm(stats[0], min, max));//0

        arduino.SetColors(new color[] {
          asic, eurc, samc, namc, afrc, ocec
        }
        );

        return;
      }

      if (mo.text.equals("HOMICIDE RATE")) {
        color c1 = color(#249afe);
        color c2 = color(#ff0c0d);
        float[] stats = new float[6];
        for (int j = 0; j < continents.length; j++) stats[j] = continents[j].dataPoint.homocideRate;
        float max = max(stats);
        float min = min(stats);

        asic = lerpColor(c1, c2, norm(stats[4], min, max));//4
        eurc = lerpColor(c1, c2, norm(stats[3], min, max));//3
        samc = lerpColor(c1, c2, norm(stats[5], min, max));//5
        namc = lerpColor(c1, c2, norm(stats[2], min, max));//2
        afrc = lerpColor(c1, c2, norm(stats[1], min, max));//1
        ocec = lerpColor(c1, c2, norm(stats[0], min, max));//0

        arduino.SetColors(new color[] {
          asic, eurc, samc, namc, afrc, ocec
        }
        );

        return;
      }

      if (mo.text.equals("DRUG RELATED DEATHS")) {
        color c1 = color(#ff6508);
        color c2 = color(#91ff78);
        float[] stats = new float[6];
        for (int j = 0; j < continents.length; j++) stats[j] = continents[j].dataPoint.drugRelatedDeaths;
        float max = max(stats);
        float min = min(stats);

        asic = lerpColor(c1, c2, norm(stats[4], min, max));//4
        eurc = lerpColor(c1, c2, norm(stats[3], min, max));//3
        samc = lerpColor(c1, c2, norm(stats[5], min, max));//5
        namc = lerpColor(c1, c2, norm(stats[2], min, max));//2
        afrc = lerpColor(c1, c2, norm(stats[1], min, max));//1
        ocec = lerpColor(c1, c2, norm(stats[0], min, max));//0

        arduino.SetColors(new color[] {
          asic, eurc, samc, namc, afrc, ocec
        });

        return;
      }

      if (mo.text.equals("GDP PER CAPITA")) {
        color c1 = color(#ffffff);
        color c2 = color(#36ff01);
        float[] stats = new float[6];
        for (int j = 0; j < continents.length; j++) stats[j] = continents[j].dataPoint.GDP;
        float max = max(stats);
        float min = min(stats);

        asic = lerpColor(c1, c2, norm(stats[4], min, max));//4
        eurc = lerpColor(c1, c2, norm(stats[3], min, max));//3
        samc = lerpColor(c1, c2, norm(stats[5], min, max));//5
        namc = lerpColor(c1, c2, norm(stats[2], min, max));//2
        afrc = lerpColor(c1, c2, norm(stats[1], min, max));//1
        ocec = lerpColor(c1, c2, norm(stats[0], min, max));//0

        arduino.SetColors(new color[] {
          asic, eurc, samc, namc, afrc, ocec
        }
        );

        println(norm(stats[5], min, max), norm(stats[3], min, max), norm(stats[1], min, max), norm(stats[2], min, max), norm(stats[0], min, max), norm(stats[4], min, max));

        return;
      }

      if (mo.text.equals("OVERWEIGHT")) {
        color c1 = color(#abff89);
        color c2 = color(#ff309b);
        float[] stats = new float[6];
        for (int j = 0; j < continents.length; j++) stats[j] = continents[j].dataPoint.overweight;
        float max = max(stats);
        float min = min(stats);

        asic = lerpColor(c1, c2, norm(stats[4], min, max));//4
        eurc = lerpColor(c1, c2, norm(stats[3], min, max));//3
        samc = lerpColor(c1, c2, norm(stats[5], min, max));//5
        namc = lerpColor(c1, c2, norm(stats[2], min, max));//2
        afrc = lerpColor(c1, c2, norm(stats[1], min, max));//1
        ocec = lerpColor(c1, c2, norm(stats[0], min, max));//0

        arduino.SetColors(new color[] {
          asic, eurc, samc, namc, afrc, ocec
        }
        );

        return;
      }
    }
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

