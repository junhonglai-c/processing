// Brand colors
color c1, c2, c3;

void setup() {
  size(400, 300);
  
  c1 = color(11, 12, 16);    // Black
  c2 = color(69, 162, 158);  // Cyan
  c3 = color(102, 100, 255); // Blue
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      
      // Normalize X
      float normalizedX = map(x, 0, width - 1, 0, 1); 
      color c; 
      
      // Multi-stop gradient
      if (normalizedX < 0.5) {
        c = lerpColor(c1, c2, map(normalizedX, 0, 0.5, 0, 1));
      } else {
        c = lerpColor(c2, c3, map(normalizedX, 0.5, 1, 0, 1));
      }

      pixels[x + y * width] = c; 
    }
  }
  updatePixels();
}
