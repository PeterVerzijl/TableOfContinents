void led(int cont, int R, int G, int B) {
  setContinentColor[cont][0] = R;
  setContinentColor[cont][1] = G;
  setContinentColor[cont][2] = B;
}

void readSerial() {
  if (Serial.available()) {
    input = "";
    nCount = 0;
    cCount = 0;
    while (Serial.available()) {
      if (Serial.available() > 0) {
        char c = Serial.read();
        input += c;
        if (c == 'n') {
          nCount ++;
        }
        if (c == ',') {
          cCount ++;
        }
      }
      //loop through the continents
      for (int i = 0; i < continentSize; i++) {
        //split the long String into continent strings
        String conti = getValue(input, 'n', i); // n is split identifier
        for (int j = 0; j < protocolSize; j++) {
          //spit the continent string into smaller strings
          String val = getValue(conti, ',', j); //, is the split identifier
          //convert string to int and put it in the matrix
          if (nCount == 6 && ( cCount == 18 || cCount == 24)) {
            numbers[i][j] = val.toInt();
          }
        }
      } 
    }
    if (nCount != 6 && cCount != 18 && cCount !=24) {
        Serial.write("R\n");  //send R for resent
      }
      
  }
}
//DO NOT TOUCH THIS
//You don't have to understand this to work with it
String getValue(String data, char separator, int index)
{
  int found = 0;
  int strIndex[] = {
    0, -1
  };
  int maxIndex = data.length() - 1;
  for (int i = 0; i <= maxIndex && found <= index; i++) {
    if (data.charAt(i) == separator || i == maxIndex) {
      found++;
      strIndex[0] = strIndex[1] + 1;
      strIndex[1] = (i == maxIndex) ? i + 1 : i;
    }
  }
  return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}

