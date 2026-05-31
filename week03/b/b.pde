void setup() {
  size(800, 800);
  background(255);
  noStroke();
  
  blendMode(DIFFERENCE); 
  
  // Reduce grid step
  int step = 50; 
  int counter = 0; 
  
  for (int x = -50; x <= width + 50; x += step) {
    for (int y = -50; y <= height + 50; y += step) {
      
      pushMatrix();
      translate(x, y); 
      int shapeType = counter % 3; 
      
      // Enlarge shapes to force overlap
      if (shapeType == 0) {
        fill(255, 96, 96); 
        ellipse(0, 0, 100, 100); 
        
      } else if (shapeType == 1) {
        fill(96, 255, 96); 
        rectMode(CENTER); 
        rotate(radians(45)); 
        rect(0, 0, 85, 85); 
        
      } else if (shapeType == 2) {
        fill(96, 96, 255); 
        triangle(0, 50, -55, -45, 55, -45); 
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
    saveFrame("abstract-art-overlap-####.png");
    println("Saved!");
  }
}
