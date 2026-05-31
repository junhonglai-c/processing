import processing.sound.*;

SinOsc myOsc;
Amplitude ampAnalyzer;

float lfoValue;

void setup() {
  size(600, 600);
  background(10);
  
  myOsc = new SinOsc(this);
  myOsc.play();
  myOsc.amp(0.4);
  
  ampAnalyzer = new Amplitude(this);
  ampAnalyzer.input(myOsc);
}

void draw() {
  fill(10, 40);
  noStroke();
  rect(0, 0, width, height);

  lfoValue = sin(frameCount * 0.1); //LFO
  float currentFreq = map(lfoValue, -1, 1, 200, 800);
  myOsc.freq(currentFreq);


//
  float currentVol = ampAnalyzer.analyze();
//1  
  float shapeSize = map(currentVol, 0, 0.4, 50, 400);
//2 
  float r = map(lfoValue, -1, 1, 50, 255);
  float b = map(lfoValue, -1, 1, 255, 50);

//
  translate(width / 2, height / 2);
  
  noFill();
  strokeWeight(3);
  stroke(r, 100, b);
  ellipse(0, 0, shapeSize, shapeSize);
  
  rotate(frameCount * 0.02); 
  stroke(255);
  strokeWeight(1);
  rectMode(CENTER);
  rect(0, 0, shapeSize * 0.4, shapeSize * 0.4);
}
