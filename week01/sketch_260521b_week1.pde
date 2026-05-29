color c1, c2, c3;

void setup() {
  size(400, 300);
  
  // Palette setup
  c1 = color(43, 25, 61);    // Outer
  c2 = color(204, 88, 81);   // Mid
  c3 = color(235, 178, 107); // Inner
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      
      // Pixel dist to center
      float d = dist(x, y, width/2, height/2);
      
      // Max radius
      float maxDist = dist(0, 0, width/2, height/2);
      
      // Normalize to 0.0-1.0
      float percent = map(d, 0, maxDist, 0, 1); 
      
      color c;
      // Multi-color radial blend
      if (percent < 0.5) {
        c = lerpColor(c3, c2, map(percent, 0, 0.5, 0, 1));
      } else {
        c = lerpColor(c2, c1, map(percent, 0.5, 1, 0, 1));
      }

      pixels[x + y * width] = c; 
    }
  }
  updatePixels();
}
