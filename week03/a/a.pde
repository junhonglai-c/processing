void setup() {
  size(800, 800);
  background(255);
  noStroke();
  
  blendMode(DIFFERENCE); 
  
  int step = 80; 
  int counter = 0; 
  
  // Generate grid
  for (int x = 40; x < width; x += step) {
    for (int y = 40; y < height; y += step) {
      
      pushMatrix();
      translate(x, y); 
      
      // Alternate patterns
      int shapeType = counter % 3; 
      
      if (shapeType == 0) {
        fill(255, 96, 96); 
        ellipse(0, 0, 60, 60);
        
      } else if (shapeType == 1) {
        fill(96, 255, 96); 
        rectMode(CENTER); 
        rotate(radians(45)); 
        rect(0, 0, 50, 50); 
        
      } else if (shapeType == 2) {
        fill(96, 96, 255); 
        triangle(0, 30, -35, -30, 35, -30); 
      }
      
      popMatrix(); 
      counter++; 
    }
  }
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("abstract-art-####.png");
    println("Saved!");
  }
}
