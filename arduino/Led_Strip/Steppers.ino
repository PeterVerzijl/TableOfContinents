#define AMOUNTSTEPPERS 2
#define MAXHEIGHTINSTEPS 1000 //TODO SETCORRECT NUMBER
#define MAXHEIGHT 100.0
#define DOWN true
#define UP false
#define STEPPERDELAY 1000

typedef struct Stepper Stepper;

struct Stepper {
  int directionPort;
  int PWMPort;
  float height;
  int caliPort;
};

Stepper steppers[AMOUNTSTEPPERS];

void setupSteppers(){
  //set how the steppers are connected //TODO add other steppers
  steppers[0].directionPort = 2;
  steppers[0].PWMPort = 4;
  steppers[0].caliPort = 8;
  
  steppers[1].directionPort = 5;
  steppers[1].PWMPort = 6;
  steppers[1].caliPort = 7;


  //set ports and calibrate all steppers
  for(int i = 0; i < AMOUNTSTEPPERS; i++){
    pinMode(steppers[i].directionPort, OUTPUT);
    pinMode(steppers[i].PWMPort, OUTPUT);
    pinMode(steppers[i].caliPort, INPUT);
    calib(i);
  }
}

void rotate(int stepper,boolean down,int steps){ //rotate in direction right == true; left == false and for x amount of steps
  if(down)
    digitalWrite(steppers[stepper].directionPort, HIGH); //check if this is right
  else
    digitalWrite(steppers[stepper].directionPort, LOW);
  for (int i = 0; i < steps; i++) {
    if(!bottom(stepper)){
      digitalWrite(steppers[stepper].PWMPort, LOW);
      delayMicroseconds(STEPPERDELAY);
      digitalWrite(steppers[stepper].PWMPort, HIGH);
      delayMicroseconds(STEPPERDELAY);
    }
    else{
      upFromBottom(stepper);
      break;
    }
  }
}

void calib(int stepper){ //Set the Steppermotor to bottom most position
  while(!bottom(stepper)){
    rotate(stepper,DOWN,1);//TODO is right the down direction
  }
  steppers[stepper].height = 0;
  upFromBottom(stepper);
}

boolean bottom(int stepper){
  return digitalRead(steppers[stepper].caliPort);
}

void upFromBottom(int stepper){
   steppers[stepper].height = 0;
  digitalWrite(steppers[stepper].directionPort, LOW); //check if this is right
  while(bottom(stepper)){
    digitalWrite(steppers[stepper].PWMPort, LOW);
    delayMicroseconds(STEPPERDELAY);
    digitalWrite(steppers[stepper].PWMPort, HIGH);
    delayMicroseconds(STEPPERDELAY);
    steppers[stepper].height += 1.0 / MAXHEIGHT;
  } 
  Serial.println(steppers[stepper].height);
}

void setHeight(int stepper,float height){ 
  int steps = int(((steppers[stepper].height - height) / MAXHEIGHT) * MAXHEIGHTINSTEPS); //calculate the amount of steps the stepper has to set //TODO if negative move downwards is this move left or right??????
  Serial.println(steps);
  Serial.println(height);
  steppers[stepper].height = height;
  rotate(stepper,steps > 0,abs(steps)); //TODO is direction correcct?  
}


