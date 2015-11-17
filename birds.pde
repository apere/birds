// author: adam m pere
// november.2015
//
// Base 'flocking' code from
// * Daniel Shiffman <http://www.shiffman.net>
// * The Nature of Code, Spring 2009

// 

import processing.serial.*;


Serial port;   
int pulseSensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int IBI;         // HOLDS TIME BETWEN HEARTBEATS FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
boolean beat = false;  
int heart = 0;   // This variable times the heart image 'pulse' on screen

Flock flock;
Flock flock2;
ArrayList<PImage> frames;
PVector noForce;
PVector pulse;
PVector reversePulse;
boolean inPulse; 

void setup() {
  fullScreen();
  try {
    port = new Serial(this, Serial.list()[5], 115200); 
    port.clear(); // flush buffer
    port.bufferUntil('\n'); 
  } catch(RuntimeException e) {
     e.printStackTrace(); 
  }
  
  flock = new Flock();
  flock2 = new Flock();
  smooth();
  frames = new ArrayList<PImage>();
  //frames.add(loadImage("texture.png"));
  //frames.add(loadImage("texture1.png"));
  //frames.add(loadImage("texture2.png"));
  //frames.add(loadImage("texture3.png"));
  //frames.add(loadImage("texture4.png"));
  
  //for(int i = 0; i < 50; i++) {
  //  Boid b = new Boid(width/2, height/2, random(-10, 20), 50*30, frames, 3);
  //  flock.addBoid(b);
  //}
  
  noForce = new PVector(0,0,0);
  pulse = new PVector(0, -.2,-.2);
  reversePulse = new PVector(0, 1.2, 1.2);
  inPulse = false;
  frameRate(30);
}
void draw() {
  background(0);
  
  if(pulseSensor >= 520 && BPM > 0 && BPM <= 95) {
    if(frameCount % 5 == 0) {
      for(int i = 0; i < pulseSensor%14; i++) {
        float bpm = map(BPM, 60, 100, 2, 5);
        float h = map(pulseSensor, 450, 590, -600, -900);
         Boid b = new Boid(width - 50, random(height - 50, height - 100) - pulseSensor/8, random(-50, -30),600, frames, bpm, 1);
         flock.addBoid(b);
         Boid b2 = new Boid(width - 50, random(50, 100), random(h, h - 20),650, frames, bpm, -1);
         flock2.addBoid(b2);
      }
    }
     flock.run(pulseSensor, noForce);
     //flock2.run(pulseSensor, noForce);
     inPulse = true;
  } else if(pulseSensor < 550 && inPulse) {
     flock.run(pulseSensor, noForce);
     //flock2.run(pulseSensor, noForce);
     inPulse = false;
  }
  else {
     flock.run(pulseSensor, noForce); 
     //flock2.run(pulseSensor, noForce);
  }
  
 
 
  text("BPM: " + BPM, 10, height - 10);text("BPM: " + BPM, 10, height - 10);
  fill(255);
  if(pulseSensor > 520 && BPM > 0) {
     fill(255, 20, 90); 
  }
  text("Framerate: " + int(frameRate),90,height-10);
  
}


void mouseDragged() {
  //flock.addBoid(new Boid(mouseX,mouseY, random(-20, 20), BPM));
}