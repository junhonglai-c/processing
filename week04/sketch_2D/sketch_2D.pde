float noiseOffset = 0;    
float playerY;            
boolean gameOver = false;

color playerColor = color(255, 78, 80); 
color terrainColor = color(2, 65, 166); 

void setup() {
  size(800, 400);
  playerY = height / 2;
  noStroke();
}

void draw() {
  background(20);
  
  if (!gameOver) {
    drawTerrain();
    updatePlayer();
    checkCollision();
  } else {
    drawTerrain();
    fill(playerColor);
    ellipse(150, playerY, 30, 30);
    
    filter(INVERT); 
    
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
  
  for (int x = 0; x < width; x += 5) {
    float y = map(noise(xoff), 0, 1, height * 0.4, height);
    rect(x, y, 5, height - y); 
    xoff += 0.02; 
  }
  
  noiseOffset += 0.03; 
}

void updatePlayer() {
  playerY = lerp(playerY, mouseY, 0.1); 
  
  fill(playerColor);
  ellipse(150, playerY, 30, 30);
}

void checkCollision() {
  float currentTerrainNoise = noise(noiseOffset + (150 * 0.02 / 5)); 
  float terrainYAtPlayer = map(currentTerrainNoise, 0, 1, height * 0.4, height);
  
  if (playerY + 15 > terrainYAtPlayer) {
    gameOver = true;
  }
}

void mousePressed() {
  if (gameOver) {
    gameOver = false;
    noiseOffset = random(1000); 
  }
}
