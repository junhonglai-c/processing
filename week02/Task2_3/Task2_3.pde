// Version 3: The Hue Prism

PImage img;
int threshold = 150; 

void setup() {
  size(800, 800);
  img = loadImage("input.jpg");
  surface.setSize(img.width, img.height);
  
  colorMode(HSB, 360, 100, 100);
  img.loadPixels();

  println("Processing... Please wait, this version is slow!");

  for (int x = 0; x < img.width; x++) {
    int y = 0;
    
    while (y < img.height) {
      
      while (y < img.height && brightness(img.pixels[x + y * img.width]) < threshold) {
        y++;
      }
      if (y >= img.height) break;
      int startY = y;
      
      while (y < img.height && brightness(img.pixels[x + y * img.width]) >= threshold) {
        y++;
      }
      int endY = y;
      int intervalLength = endY - startY;
      
      color[] intervalPixels = new color[intervalLength];
      for (int i = 0; i < intervalLength; i++) {
        intervalPixels[i] = img.pixels[x + (startY + i) * img.width];
      }
      
      // Custom selection sort by Hue
      for (int i = 0; i < intervalPixels.length - 1; i++) {
        int minIndex = i;
        for (int j = i + 1; j < intervalPixels.length; j++) {
          if (hue(intervalPixels[j]) < hue(intervalPixels[minIndex])) {
            minIndex = j;
          }
        }
        color temp = intervalPixels[i];
        intervalPixels[i] = intervalPixels[minIndex];
        intervalPixels[minIndex] = temp;
      }
      
      for (int i = 0; i < intervalLength; i++) {
        img.pixels[x + (startY + i) * img.width] = intervalPixels[i];
      }
    }
  }
  
  img.updatePixels();
  colorMode(RGB, 255);
  println("Done!");
}

void draw() {
  image(img, 0, 0);
}

void keyPressed() {
  if (key == 's') {
    saveFrame("version3-hue-####.png");
    println("Saved Version 3!");
  }
}
