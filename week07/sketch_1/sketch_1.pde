import processing.sound.*;

SinOsc lfo; // Low Frequency Oscillator

void setup() {
  size(800, 800);
  background(255);
  noStroke();
  
  blendMode(DIFFERENCE); 
  
  // Setup LFO for visual modulation
  lfo = new SinOsc(this);
  lfo.freq(0.5); // Very slow frequency (1 cycle per 2 seconds)
  lfo.amp(1.0);  // Output range -1.0 to 1.0
  lfo.play();
}

void draw() {
  background(255); // Clear background each frame for animation
  
  int step = 50; 
  int counter = 0; 

  float modValue = sin(frameCount * 0.02); 
  
  // Map LFO to size domain (pulsing shapes)
  float dynamicSize = map(modValue, -1, 1, 60, 140);
  
  // Map LFO to rotation domain
  float dynamicRotation = map(modValue, -1, 1, 0, PI);

  for (int x = -50; x <= width + 50; x += step) {
    for (int y = -50; y <= height + 50; y += step) {
      
      pushMatrix();
      translate(x, y); 
      
      int shapeType = counter % 3; 
      
      if (shapeType == 0) {
        fill(255, 96, 96); 
        ellipse(0, 0, dynamicSize, dynamicSize); 
      } else if (shapeType == 1) {
        fill(96, 255, 96); 
        rectMode(CENTER); 
        // Square rotates based on LFO
        rotate(radians(45) + dynamicRotation); 
        rect(0, 0, dynamicSize * 0.85, dynamicSize * 0.85); 
      } else if (shapeType == 2) {
        fill(96, 96, 255); 
        // Triangle scales based on LFO
        float tScale = map(dynamicSize, 60, 140, 0.6, 1.4);
        scale(tScale);
        triangle(0, 50, -55, -45, 55, -45); 
      }
      
      popMatrix(); 
      counter++; 
    }
  }
}
