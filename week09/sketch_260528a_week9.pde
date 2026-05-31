Unicorn player;
ArrayList<Platform> platforms;
ArrayList<Star> stars;

boolean gameOver = false;
int score = 0;
float globalSpeed = 6; 

PVector gravity = new PVector(0, 0.7);

void setup() {
  size(800, 600);
  player = new Unicorn(150, 200);
  platforms = new ArrayList<Platform>();
  stars = new ArrayList<Star>();
  
  platforms.add(new Platform(100, 400, 800)); // Start platform
  
  gameOver = false;
  score = 0;
  globalSpeed = 6;
}

void draw() {
  background(20, 10, 40); // Dark synthwave sky
  
  // Parallax stars background
  fill(255);
  noStroke();
  for (int i = 0; i < 5; i++) {
    ellipse((frameCount * -1 + i * 200) % width + width, random(height), 2, 2);
  }
  
  if (!gameOver) {
    globalSpeed += 0.002; // Gradually increase difficulty
    
    // Spawn platforms & stars
    if (frameCount % (int)(700 / globalSpeed) == 0) {
      float py = random(250, 500);
      platforms.add(new Platform(width, py, random(200, 400)));
      if (random(1) > 0.5) stars.add(new Star(width + 100, py - 60)); // Spawn star
    }
    
    // Update platforms
    for (int i = platforms.size() - 1; i >= 0; i--) {
      Platform p = platforms.get(i);
      p.update();
      p.display();
      if (p.isOffscreen()) platforms.remove(i);
    }
    
    // Update stars
    for (int i = stars.size() - 1; i >= 0; i--) {
      Star s = stars.get(i);
      s.update();
      s.display();
      if (player.checkCollect(s)) {
        score += 100; // Bonus score
        stars.remove(i);
      } else if (s.isOffscreen()) {
        stars.remove(i);
      }
    }
    
    player.applyForce(gravity);
    player.update();
    player.checkCollision(platforms);
    player.display();
    
    if (frameCount % 10 == 0) score += 10; // Passive score
    if (player.pos.y > height) gameOver = true; // Fall death
    
    // UI
    fill(255);
    textSize(24);
    text("Score: " + score, 20, 40);
    text("Z: Jump (Double) | X: Dash", 20, 70);
    
  } else {
    fill(255, 50, 150);
    textSize(64);
    textAlign(CENTER);
    text("DREAM OVER", width/2, height/2 - 20);
    fill(255);
    textSize(24);
    text("Score: " + score + " | Press 'R' to restart", width/2, height/2 + 30);
    textAlign(LEFT);
  }
}

void keyPressed() {
  if ((key == 'z' || key == 'Z') && !gameOver) player.jump();
  if ((key == 'x' || key == 'X') && !gameOver) player.dash();
  if ((key == 'r' || key == 'R') && gameOver) setup();
}

// ==========================================
// Class 1: Player (Robot Unicorn)
// ==========================================
class Unicorn {
  PVector pos, vel, acc;
  float size = 30;
  int jumpCount = 0; // Double jump tracker
  int dashTimer = 0; // Dash duration tracker
  ArrayList<PVector> trail; // Rainbow trail history
  
  Unicorn(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    trail = new ArrayList<PVector>();
  }
  
  void applyForce(PVector force) {
    if (dashTimer <= 0) acc.add(force); // Ignore gravity while dashing
  }
  
  // Interaction 1: Double Jump
  void jump() {
    if (jumpCount < 2) {
      vel.y = -12; // Direct velocity override for snappy jump
      jumpCount++;
      dashTimer = 0; // Cancel dash
    }
  }
  
  // Interaction 2: Dash Attack
  void dash() {
    if (dashTimer <= 0) {
      dashTimer = 15; // Frames of dash
      vel.y = 0; // Lock vertical movement
      vel.x = 10; // Burst forward
    }
  }
  
  void update() {
    // Handle dash logic
    if (dashTimer > 0) {
      dashTimer--;
      if (dashTimer == 0) vel.x = -2; // Drift back to start X
    } else if (pos.x > 150) {
      vel.x -= 0.5; // Spring back to default X position
    } else {
      vel.x = 0;
      pos.x = 150;
    }

    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    
    // Update rainbow trail
    trail.add(new PVector(pos.x, pos.y));
    if (trail.size() > 15) trail.remove(0);
  }
  
  void checkCollision(ArrayList<Platform> platforms) {
    for (Platform p : platforms) {
      if (pos.x + size > p.x && pos.x < p.x + p.w &&
          pos.y + size >= p.y && pos.y + size <= p.y + 20 && vel.y >= 0) {
        pos.y = p.y - size;
        vel.y = 0;
        jumpCount = 0; // Reset double jump on ground
      }
    }
  }
  
  boolean checkCollect(Star s) {
    return dist(pos.x + size/2, pos.y + size/2, s.x, s.y) < size;
  }
  
  void display() {
    // Draw Trail
    noStroke();
    color[] rainbow = {color(255,0,0), color(255,165,0), color(255,255,0), color(0,255,0), color(0,100,255)};
    for (int i = 0; i < trail.size(); i++) {
      PVector t = trail.get(i);
      fill(rainbow[i % 5], i * 15); // Fade out older trail parts
      rect(t.x, t.y, size, size);
    }
    
    // Draw Unicorn
    pushMatrix();
    translate(pos.x, pos.y);
    fill(240); // Metal body
    rect(0, 0, size, size, 4);
    fill(255, 50, 150); // Neon pink horn
    triangle(size, 5, size + 18, -5, size, 15);
    popMatrix();
  }
}

// ==========================================
// Class 2: Platform
// ==========================================
class Platform {
  float x, y, w;
  
  Platform(float x, float y, float w) {
    this.x = x; this.y = y; this.w = w;
  }
  void update() { x -= globalSpeed; }
  boolean isOffscreen() { return x + w < 0; }
  
  void display() {
    stroke(255, 50, 150); // Neon outline
    strokeWeight(3);
    fill(20); // Dark ground
    rect(x, y, w, 20);
  }
}

// ==========================================
// Class 3: Star (Collectible)
// ==========================================
class Star {
  float x, y;
  
  Star(float x, float y) {
    this.x = x; this.y = y;
  }
  void update() { x -= globalSpeed; }
  boolean isOffscreen() { return x + 20 < 0; }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(frameCount * 0.1); // Spinning star
    noStroke();
    fill(255, 255, 0);
    rectMode(CENTER);
    rect(0, 0, 15, 15);
    rotate(PI/4);
    rect(0, 0, 15, 15);
    rectMode(CORNER);
    popMatrix();
  }
}
