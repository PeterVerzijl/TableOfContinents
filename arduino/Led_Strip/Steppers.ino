typedef struct Stepper Stepper;

struct Stepper {
  int directionPort;
  int PWMPort;
  int height;
};



Stepper steppers[6];

void setupSteppers(){
  //set how the steppers are connected //TODO add other steppers
  steppers[0].directionPort = 11;
  steppers[0].PWMPort = 10;
  
}
void rotate(int stepper,boolean right,int steps){ //rotate in direction right == true; left == false and for x amount of steps
Serial.println(steppers[stepper].PWMPort);
  if(right)
    digitalWrite(steppers[stepper].directionPort, HIGH); //check if this is right
  else
    digitalWrite(steppers[stepper].directionPort, LOW);
  for (int i = 0; i < steps; i++) {
    digitalWrite(steppers[stepper].PWMPort, LOW);
    delayMicroseconds(500);
    digitalWrite(steppers[stepper].PWMPort, HIGH);
    delayMicroseconds(500);
  }
}
