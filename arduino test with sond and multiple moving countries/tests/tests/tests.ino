

/*
 * User testing for the arduino
 * Two kinds of messages can be send to the arduino:
 * -    0-255
 * - S,1,#
 *     c  rrrgggbbb
 * - L,1,C#########\n
*/

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  
}

// Serial event gets called when anything in the serial happens.
void serialEvent() {
  String s = "";
  while(Serial.available()) {
    char c = (char)Serial.read();
    s += c;
    if (c == '\n') {
      Serial.print(s);
    }
  }
}
