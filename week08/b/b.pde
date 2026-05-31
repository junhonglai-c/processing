import processing.sound.*;

SoundFile kick;
SoundFile wood;
SoundFile glass;
SoundFile snare; 

SinOsc synth;

int bpm = 120;
int framesPerBeat; 

void setup() {
  size(600, 600);
  
  frameRate(60); 
  framesPerBeat = (int)(60.0 / (bpm / 60.0)); 


  kick = new SoundFile(this, "kick.wav");
  wood = new SoundFile(this, "wood.wav");
  glass = new SoundFile(this, "glass.wav");
  snare = new SoundFile(this, "snare.wav");

  synth = new SinOsc(this);
}

void draw() {
  fill(0, 50);
  rect(0, 0, width, height);

  
  boolean isQuarterNote = (frameCount % framesPerBeat == 0);        
  boolean isEighthNote = (frameCount % (framesPerBeat / 2) == 0);   
  boolean isSixteenthNote = (frameCount % (framesPerBeat / 4) == 0);

  int beatInBar = (frameCount / framesPerBeat) % 4; 
  int barNumber = (frameCount / (framesPerBeat * 4));

  boolean playKick = false;
  boolean playSnare = false;
  boolean playWood = false;
  boolean playGlass = false;

  if (isQuarterNote) {
    if (beatInBar == 0 || beatInBar == 2) {
      kick.play();
      playKick = true;
    } else if (beatInBar == 1 || beatInBar == 3) {
      snare.play();
      playSnare = true;
    }
  }

  if (isEighthNote) {
    wood.play();
    wood.amp(random(0.4, 0.8)); 
    playWood = true;
  }

  if (barNumber % 2 == 1) {
    if (isSixteenthNote) {
      if (random(1) < 0.3) { 
        glass.rate(random(0.8, 1.5));
        glass.play();
        playGlass = true;
      }
    }
  }


  if (isQuarterNote) {
    if (beatInBar == 0 && barNumber % 4 == 0) {
      synth.play();
      synth.freq(880); 
      synth.amp(0.3);
    } else {
      synth.stop(); 
    }
  }

  
  noStroke();

  if (playKick) {
    fill(255, 50, 50);
    ellipse(width/2, height/2, 300, 300);
  }
  

  if (playSnare) {
    fill(50, 150, 255);
    rectMode(CENTER);
    rect(width/2, height/2, 400, 400);
    rectMode(CORNER); 
  }
  
  if (playWood) {
    fill(255);
    ellipse(random(width), random(height), 20, 20);
  }
  
  if (playGlass) {
    fill(255, 200, 0);
    float x = random(width);
    float y = random(height);
    triangle(x, y-20, x-20, y+20, x+20, y+20);
  }
}
