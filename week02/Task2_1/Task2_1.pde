// Version 1: The Data Waterfall

PImage img;

void setup() {
  size(800, 800); 
  img = loadImage("input.jpg");
  surface.setSize(img.width, img.height); 
  
  img.loadPixels();
  
  // Sort pixels per column
  for (int x = 0; x < img.width; x++) {
    
    color[] colPixels = new color[img.height];
    
    for (int y = 0; y < img.height; y++) {
      colPixels[y] = img.pixels[x + y * img.width];
    }
    
    colPixels = sort(colPixels); 
    
    for (int y = 0; y < img.height; y++) {
      img.pixels[x + y * img.width] = colPixels[y];
    }
  }
  
  img.updatePixels(); 
}

void draw() {
  image(img, 0, 0); 
}

void keyPressed() {
  if (key == 's') {
    saveFrame("version1-waterfall-####.png");
    println("Saved Version 1!");
  }
}
