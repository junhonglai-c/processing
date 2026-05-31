import processing.sound.*;

// 1. Declare Sound Objects
SoundFile drumLoop;
SinOsc synthOsc;
Amplitude ampAnalyzer;

int bpm = 120;
int framesPerBeat;
float lfoValue;

void setup() {
  size(800, 800);
  background(10);
  frameRate(60);
  
  framesPerBeat = (int)(60.0 / (bpm / 60.0));

  // 2. Load and play sampled loop
  drumLoop = new SoundFile(this, "glass.wav"); // Ensure this file is in your /data folder
  drumLoop.loop();
  drumLoop.amp(0.6); // Balance volume with synth

  // 3. Setup Synth (from previous week)
  synthOsc = new SinOsc(this);
  synthOsc.play();
  synthOsc.amp(0.2); // Keep oscillator slightly quieter
  
  // Audio analysis
  ampAnalyzer = new Amplitude(this);
  ampAnalyzer.input(synthOsc); // Or input(drumLoop) depending on what you want to visualize
}

void draw() {
  // Motion blur trail
  fill(10, 40);
  noStroke();
  rect(0, 0, width, height);
  
  // --- Audio Logic ---
  // Rhythmic LFO synchronized with BPM (approximate)
  float lfoSpeed = (TWO_PI / (framesPerBeat * 4)); // Complete one LFO cycle every 4 beats
  lfoValue = sin(frameCount * lfoSpeed); 
  
  // Frequency modulation (FM) for the synth
  float currentFreq = map(lfoValue, -1, 1, 100, 600);
  synthOsc.freq(currentFreq);

  // Musical Gate: Only play synth on the first beat of every bar
  int beatInBar = (frameCount / framesPerBeat) % 4;
  if (beatInBar == 0) {
    synthOsc.amp(0.3); // Turn up
  } else {
    synthOsc.amp(0.0); // Silence
  }

  // --- Visual Logic ---
  float currentVol = ampAnalyzer.analyze();
  float shapeSize = map(currentVol, 0, 0.3, 50, 600); // Scale up based on volume
  
  float r = map(lfoValue, -1, 1, 50, 255);
  float b = map(lfoValue, -1, 1, 255, 50);

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
