PImage sample;

void setup() {
  size(800, 600); 
  sample = loadImage("sample.jpg");
  
  // Swap channels once
  sample.loadPixels();
  for (int i = 0; i < sample.pixels.length; i++) {
    color c = sample.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    // RGB to BGR
    sample.pixels[i] = color(b, g, r); 
  }
  sample.updatePixels(); 
}

void draw() {
  // Draw modified image
  image(sample, 0, 0);

  int[] histR = new int[256];
  int[] histG = new int[256];
  int[] histB = new int[256];
  
  sample.loadPixels();
  
  // Tally color distributions
  for (int i = 0; i < sample.pixels.length; i++) {
    color c = sample.pixels[i];
    histR[int(red(c))]++;
    histG[int(green(c))]++;
    histB[int(blue(c))]++;
  }  

  int overallMax = max(max(max(histR), max(histG)), max(histB));

  // Draw composite histogram
  blendMode(ADD); 
  for (int i = 0; i < 256; i++) {
    // Scale X to width
    float x = i * (width / 256.0); 
    
    stroke(255, 0, 0); // Red
    line(x, height, x, map(histR[i], 0, overallMax, height, height - 200));

    stroke(0, 255, 0); // Green
    line(x, height, x, map(histG[i], 0, overallMax, height, height - 200));

    stroke(0, 0, 255); // Blue
    line(x, height, x, map(histB[i], 0, overallMax, height, height - 200));
  }
  blendMode(BLEND); // Reset blend mode
}
