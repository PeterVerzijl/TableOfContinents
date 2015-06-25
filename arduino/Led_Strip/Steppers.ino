#define AMOUNTSTEPPERS 6
#define MAXHEIGHTINSTEPS 1000 //TODO SETCORRECT NUMBER
#define MAXHEIGHT 100.0
#define DOWN true
#define UP false
#define STEPPERDELAY 2000

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
  steppers[0].directionPort = 22;
  steppers[0].PWMPort = 2;
  steppers[0].caliPort = 30;

  steppers[1].directionPort = 23;
  steppers[1].PWMPort = 3;
  steppers[1].caliPort = 31;

  steppers[2].directionPort = 24;
  steppers[2].PWMPort = 4;
  steppers[2].caliPort = 32;

  steppers[3].directionPort = 25;
  steppers[3].PWMPort = 5;
  steppers[3].caliPort = 33;

  steppers[4].directionPort = 26;
  steppers[4].PWMPort = 6;
  steppers[4].caliPort = 34;

  steppers[5].directionPort = 27;
  steppers[5].PWMPort = 7;
  steppers[5].caliPort = 35;




  //  //set ports and calibrate all steppers
  for(int i = 0; i < AMOUNTSTEPPERS; i++){
    pinMode(steppers[i].directionPort, OUTPUT);
    pinMode(steppers[i].PWMPort, OUTPUT);
    pinMode(steppers[i].caliPort, INPUT);
    calib(i);
  }
  Serial.write("READY\n");
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

<<<<<<< HEAD
void setHeigthMultiple(int numbers[6][3]){
  Steps steps[AMOUNTSTEPPERS];
  for(int i = 0; i < AMOUNTSTEPPERS; i++){ //calculate the amount of steps all steppers have to move
    steppers[i].height = numbers[i][3]; //set height of steppers
    int amountOfSteps = int(((steppers[i].height - numbers[i][3]) / MAXHEIGHT) * MAXHEIGHTINSTEPS);
    steps[i].steps = abs(amountOfSteps); //steps
    steps[i].down = amountOfSteps > 0; //direction
    if(amountOfSteps ==0) //if stepper does not have to move
      steps[i].finished = true;
    else
      steps[i].finished = false;
  }
  for(int q = 0; q < AMOUNTSTEPPERS; q++){ //set direction of all steppermotors
    if(steps[q].down)
      digitalWrite(steppers[q].directionPort, HIGH);
    else
      digitalWrite(steppers[q].directionPort, LOW);
  }
  for(int i = 0; i < MAXHEIGHTINSTEPS * 1.2; i++){ //the maximum amount of steps all steppers can take
    if(steppersfinished() >= AMOUNTSTEPPERS){ //if not all steppers have finished moving
      for(int q = 0; q < AMOUNTSTEPPERS; q++){ //for all steppers
        if(!steps[q].finished && steps[q].steps > 0){ //if stepper has not finished movement
          if(!bottom(q)){//steppers has not reached the bottom
            steps[q].steps--;
            digitalWrite(steppers[q].PWMPort, LOW);
          }
          else{ //if reached the botttom
            steps[q].finished = true;
            upFromBottom(q);
            break;
          }
        }
        else{ //if finished with taking steps
          steps[q].finished = true;
          break;
        }
      }
      delayMicroseconds(STEPPERDELAY);
      for(int q = 0; q < AMOUNTSTEPPERS; q++){
        if(!steps[q].finished && steps[q].steps > 0){ //if stepper has not finished movement
          if(!bottom(q)){
            digitalWrite(steppers[q].PWMPort, HIGH);
          }
          else{
            steps[q].finished = true;
            upFromBottom(q);
            continue;
          }
        }
        else{
          steps[q].finished = true;
          continue;
        }
      }
      delayMicroseconds(STEPPERDELAY);
    }
    else
      break;
  }
}

int steppersfinished(){
  int finished;
  for(int i = 0; i < AMOUNTSTEPPERS; i++)
    if(steps[i].finished) finished++;

  return finished;
}

typedef struct Tone Tone;

struct Tone {
  float freq;
  float length;
    float wait;
};
#define AMOUNTNOTES 8
Tone tones[AMOUNTNOTES];
void setSong(){
  tones[0].freq = 660;
  tones[0].length = 100;
  tones[0].wait = 150;
  tones[1].freq = 660;
  tones[1].length = 100;
  tones[1].wait = 300;
  tones[2].freq = 660;
  tones[2].length = 100;
  tones[2].wait = 300;
  tones[3].freq = 510;
  tones[3].length = 100;
  tones[3].wait = 100;
  tones[4].freq = 660;
  tones[4].length = 100;
  tones[4].wait = 300;
  tones[5].freq = 770;
  tones[5].length = 100;
  tones[5].wait = 550;
  tones[6].freq = 380;
  tones[6].length = 100;
  tones[6].wait = 575;
}
void song(){

  for(int i = 0; i < AMOUNTSTEPPERS; i++)  //set all in the middle
    setHeight(i, 50);

  for(int i = 0; i < AMOUNTNOTES; i++){
    int country = int(random(6));
    int amountofSteps = tones[i].length / ((1.0 / tones[i].freq) * pow(10.0,3));
    boolean down;
    if(steppers[country].height < MAXHEIGHT / 2)
      down = false;
    else
      down = true;

    for (int i = 0; i < amountofSteps; i++) {
      if(steppers[country].height < 10 && down || steppers[country].height > MAXHEIGHT - 10 && !down)
        down = !down;

      if(down){
        steppers[country].height -= 1.0 / MAXHEIGHT;
        digitalWrite(steppers[country].directionPort, HIGH); //check if this is right
      }else{
        steppers[country].height += 1.0 / MAXHEIGHT;
        digitalWrite(steppers[country].directionPort, LOW);
      }

      if(!bottom(country)){
        digitalWrite(steppers[country].PWMPort, LOW);
        delayMicroseconds(1.0 / tones[i].freq * pow(10,6));
        digitalWrite(steppers[country].PWMPort, HIGH);
        delayMicroseconds(1.0 / tones[i].freq * pow(10,6));
      }
      else{
        upFromBottom(country);
        break;
      }
    }
  }
}












=======
>>>>>>> parent of c03b88a... added setting of height multiple continents





