float noiseOffset = 0;    
float playerY;            
boolean gameOver = false;

color playerColor = color(255, 78, 80); 
color terrainColor = color(2, 65, 166); 

PShape playerModel; // 3D model

void setup() {
  size(800, 400, P3D); // Enable P3D
  playerY = height / 2;
  noStroke();
  
  playerModel = loadShape("ship.obj"); 
  playerModel.disableStyle(); // Override original colors
}

void draw() {
  background(20);
  lights(); // 3D lighting
  
  if (!gameOver) {
    drawTerrain();
    updatePlayer();
    checkCollision();
  } else {
    drawTerrain();
    
    // Static game over state
    pushMatrix();
    translate(150, playerY, 0);
    fill(playerColor);
    scale(15); 
    shape(playerModel);
    popMatrix();
    
    filter(INVERT); // Glitch effect
    
    fill(255);
    textSize(48);
    textAlign(CENTER);
    text("SYSTEM FAILURE", width/2, height/2);
    textSize(18);
    text("Click to Reboot", width/2, height/2 + 40);
  }
}

void drawTerrain() {
  fill(terrainColor);
  float xoff = noiseOffset;
  
  // Generate terrain
  for (int x = 0; x < width; x += 5) {
    float y = map(noise(xoff), 0, 1, height * 0.4, height);
    rect(x, y, 5, height - y); 
    xoff += 0.02; 
  }
  noiseOffset += 0.03; // Scroll speed
}

void updatePlayer() {
  playerY = lerp(playerY, mouseY, 0.1); // Smooth follow
  
  pushMatrix();
  translate(150, playerY, 0);
  
  float tilt = (mouseY - playerY) * 0.05; // Dynamic pitch
  rotateZ(tilt); 
  
  fill(playerColor);
  scale(15); 
  shape(playerModel); 
  popMatrix();
}

void checkCollision() {
  // Sync noise to player X (150)
  float terrainNoise = noise(noiseOffset + (150 * 0.02 / 5)); 
  float terrainY = map(terrainNoise, 0, 1, height * 0.4, height);
  
  // Hitbox radius = 15
  if (playerY + 15 > terrainY) {
    gameOver = true;
  }
}

void mousePressed() {
  if (gameOver) {
    gameOver = false;
    noiseOffset = random(1000); // Reset terrain
  }
}
