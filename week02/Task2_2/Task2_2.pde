// Version 2: Highlight Collapse

PImage img;
int threshold = 180; // Brightness threshold (0-255)

void setup() {
  size(800, 800);
  img = loadImage("input.jpg");
  surface.setSize(img.width, img.height);
  
  img.loadPixels();

  for (int x = 0; x < img.width; x++) {
    int y = 0;
    
    while (y < img.height) {
      
      // Find highlight start
      while (y < img.height && brightness(img.pixels[x + y * img.width]) < threshold) {
        y++;
      }
      
      if (y >= img.height) break;
      
      int startY = y;
      
      // Find highlight end
      while (y < img.height && brightness(img.pixels[x + y * img.width]) >= threshold) {
        y++;
      }
      
      int endY = y;
      int intervalLength = endY - startY;
      
      // Extract pixels
      color[] intervalPixels = new color[intervalLength];
      for (int i = 0; i < intervalLength; i++) {
        intervalPixels[i] = img.pixels[x + (startY + i) * img.width];
      }
      
      // Sort
      intervalPixels = sort(intervalPixels);
      
      // Write back reversed
      for (int i = 0; i < intervalLength; i++) {
        img.pixels[x + (startY + i) * img.width] = intervalPixels[intervalLength - 1 - i];
      }
    }
  }
  
  img.updatePixels();
}

void draw() {
  image(img, 0, 0);
}

void keyPressed() {
  if (key == 's') {
    saveFrame("version2-highlight-####.png");
    println("Saved Version 2!");
  }
}
