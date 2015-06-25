/*
example command: 
255,255,0,10,n200,255,100,90,n255,255,0,10,n255,255,0,0,n255,255,0,10,n255,255,0,0,n

30,255,0,90,n170,255,90,70,n255,255,0,10,n255,255,0,0,n255,255,0,10,n255,255,0,0,n

255,120,50,70,n200,0,255,70,n255,255,0,70,n25,255,0,70,n255,255,0,70,n255,55,0,70,n
*/

#include "FastLED.h"

// total led's in series
#define NUM_LEDS 16

// define updates per second
#define updatesPerSecond 100

// fade_duration 1 = 2,55sec, 2 = 1,27sec, 3 = 0,85sec, etc
int fadeValue = 1;
unsigned long counter = 0;

// led's per continent (ideal: total should add up to NUM_LEDS
int continent [6] = {4, 6, 10, 12, 14, 16};  //order: first continent -> last continent (1,2 - 3,4, etc)

//define the data pin
#define DATA_PIN 10

//make arrays for CURRENT colors (R,G,B values)
int continentColor [6][3];

//make arrays for the color TO BE SET (R,G,B value)
int setContinentColor [6][3];

//make variables for serial communication
int numbers[6][4];
String input;
int continentSize = 6; //amount of continents
int protocolSize = 4; //amount of values sent like this R,G,B,height
int nCount =0;  //error correction "n" count
int cCount =0;  //error correction "," count

// Define the array of leds
CRGB leds[NUM_LEDS];

void setup() {
  Serial.begin(9600);
  //define the type of chip
  FastLED.addLeds<WS2811, DATA_PIN, RGB>(leds, NUM_LEDS);
setupSteppers();
}

void loop() {

  //depending on the input, make the leds be set to another value
  readSerial();
  for(int i = 0; i < continentSize; i++){
    led(i,numbers[i][0],numbers[i][1],numbers[i][2]); 
    setHeight(i,numbers[i][3]);
  }

  //Fade to the color TO BE SET for each continent
  if (millis() > counter + 1000/updatesPerSecond) {
    counter = millis();
    for (int j = 0; j < 6; j++) {
      for (int i = 0; i < 3; i++) {
        if (continentColor[j][i] < setContinentColor[j][i] - fadeValue) {
          continentColor[j][i] += fadeValue;
        }
        if (continentColor[j][i] > setContinentColor[j][i] + fadeValue) {
          continentColor[j][i] -= fadeValue;
        }
      }
    }
  }

  //show the leds (CURRENT colors)
  for (int i = 0; i < NUM_LEDS; i++) {
    if (i < continent[0]) {
      leds[i] = CRGB(continentColor[0][0], continentColor[0][2], continentColor[0][1]); //RGB = RBG (manufacturing fail @ China
    }
    if (i < continent[1] && i > continent[0] - 1) {
      leds[i] = CRGB(continentColor[1][0], continentColor[1][2], continentColor[1][1]); //RGB = RBG (manufacturing fail @ China
    }
    if (i < continent[2] && i > continent[1] - 1) {
      leds[i] = CRGB(continentColor[2][0], continentColor[2][2], continentColor[2][1]); //RGB = RBG (manufacturing fail @ China
    }
    if (i < continent[3] && i > continent[2] - 1) {
      leds[i] = CRGB(continentColor[3][0], continentColor[3][2], continentColor[3][1]); //RGB = RBG (manufacturing fail @ China
    }
    if (i < continent[4] && i > continent[3] - 1) {
      leds[i] = CRGB(continentColor[4][0], continentColor[4][2], continentColor[4][1]); //RGB = RBG (manufacturing fail @ China
    }
    if (i < continent[5] && i > continent[4] - 1) {
      leds[i] = CRGB(continentColor[5][0], continentColor[5][2], continentColor[5][1]); //RGB = RBG (manufacturing fail @ China
    }
  }
  FastLED.show();
}







