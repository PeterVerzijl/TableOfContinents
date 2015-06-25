#define AMOUNTSTEPPERS 6
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

  steppers[1].directionPort = 2;
  steppers[1].PWMPort = 4;
  steppers[1].caliPort = 8;

  steppers[2].directionPort = 2;
  steppers[2].PWMPort = 4;
  steppers[2].caliPort = 8;

  steppers[3].directionPort = 2;
  steppers[3].PWMPort = 4;
  steppers[3].caliPort = 8;

  steppers[4].directionPort = 2;
  steppers[4].PWMPort = 4;
  steppers[4].caliPort = 8;

  steppers[5].directionPort = 2;
  steppers[5].PWMPort = 4;
  steppers[5].caliPort = 8;




  //  //set ports and calibrate all steppers
  for(int i = 0; i < AMOUNTSTEPPERS; i++){
    pinMode(steppers[i].directionPort, OUTPUT);
    pinMode(steppers[i].PWMPort, OUTPUT);
    pinMode(steppers[i].caliPort, INPUT);
    calib(i);
  }
   Serial.write("READY");
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
  for(int i = 0; i < MAXHEIGHTINSTEPS * 1.2; i++){
    if(!bottom(stepper)){
      rotate(stepper,DOWN,1);//TODO is right the down direction
    }
    else
      break; 
  }
  steppers[stepper].height = 0;
  upFromBottom(stepper);
}

boolean bottom(int stepper){
  return digitalRead(steppers[stepper].caliPort);
}

void upFromBottom(int stepper){
  steppers[stepper].height = 0;
  digitalWrite(steppers[stepper].directionPort, LOW); 
  for(int i = 0; i < MAXHEIGHTINSTEPS * 1.2; i++){
    if(bottom(stepper)){
      digitalWrite(steppers[stepper].PWMPort, LOW);
      delayMicroseconds(STEPPERDELAY);
      digitalWrite(steppers[stepper].PWMPort, HIGH);
      delayMicroseconds(STEPPERDELAY);
      steppers[stepper].height += 1.0 / MAXHEIGHT;
    }
    else
      break;
  }
}

void setHeight(int stepper,float height){ 
  if(steppers[stepper].height != height){
    int steps = int(((steppers[stepper].height - height) / MAXHEIGHT) * MAXHEIGHTINSTEPS); //calculate the amount of steps the stepper has to set //TODO if negative move downwards is this move left or right??????
    steppers[stepper].height = height;
    rotate(stepper,steps > 0,abs(steps)); //TODO is direction correcct?  
  }
}






