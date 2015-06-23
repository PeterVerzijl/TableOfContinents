#define AMOUNTSTEPPERS 6
#define MAXHEIGHTINSTEPS 1000 //TODO SETCORRECT NUMBER
#define MAXHEIGHT 100

typedef struct Stepper Stepper;

struct Stepper {
  int directionPort;
  int PWMPort;
  int height;
  int caliPort;
};

Stepper steppers[AMOUNTSTEPPERS];

void setupSteppers(){
  //set how the steppers are connected //TODO add other steppers
  steppers[0].directionPort = 11;
  steppers[0].PWMPort = 10;
  
  
  //set ports and calibrate all steppers
  for(int i = 0; i < AMOUNTSTEPPERS; i++){
  pinMode(steppers[i].directionPort, OUTPUT);
  pinMode(steppers[i].PWMPort, OUTPUT);
  calib(i);
  }
}
void rotate(int stepper,boolean right,int steps){ //rotate in direction right == true; left == false and for x amount of steps
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

void calib(int stepper){ //Set the Steppermotor to bottom most position
  while(!digitalRead(steppers[stepper].caliPort)){
    rotate(stepper,true,1);//TODO is right the down direction
  }
  steppers[stepper].height = 0;
}

void setHeight(int stepper,int height){
  int steps = ((steppers[stepper].height - height) / MAXHEIGHT) * MAXHEIGHTINSTEPS; //calculate the amount of steps the stepper has to set //TODO if negative move downwards is this move left or right??????
  rotate(stepper,steps > 0,abs(steps)); //TODO is direction correcct?
  
  
}
