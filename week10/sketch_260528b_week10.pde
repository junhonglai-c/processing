ArrayList<LeafSystem> systems;
PVector gravity;

void setup() {
  size(800, 600);
  systems = new ArrayList<LeafSystem>();
  gravity = new PVector(0, 0.05); // Global gravity
}

void draw() {
  background(210, 230, 240); // Autumn sky

  // Randomized Force: Perlin noise wind
  float n = noise(frameCount * 0.01);
  PVector gentleWind = new PVector(map(n, 0, 1, -0.03, 0.06), 0);

  for (int i = systems.size() - 1; i >= 0; i--) {
    LeafSystem ls = systems.get(i);
    ls.applyForce(gravity);
    ls.applyForce(gentleWind);

    // Interaction: Hold 'W' for strong gust
    if (keyPressed && (key == 'w' || key == 'W')) {
      ls.applyForce(new PVector(0.15, -0.03)); // Push right and slightly up
    }

    ls.update();
    ls.display();

    if (ls.isDead()) systems.remove(i);
  }

  fill(50);
  textSize(16);
  text("Click to spawn leaves. Hold 'W' for strong wind.", 20, 30);
}

// Interaction: Spawn particles
void mousePressed() {
  systems.add(new LeafSystem(mouseX, mouseY));
}

// ==========================================
// Class: LeafSystem
// ==========================================
class LeafSystem {
  ArrayList<Leaf> leaves;

  LeafSystem(float x, float y) {
    leaves = new ArrayList<Leaf>();
    int count = (int) random(15, 30); // Random burst size
    for (int i = 0; i < count; i++) {
      leaves.add(new Leaf(x, y));
    }
  }

  void applyForce(PVector force) {
    for (Leaf l : leaves) l.applyForce(force);
  }

  void update() {
    for (int i = leaves.size() - 1; i >= 0; i--) {
      Leaf l = leaves.get(i);
      l.update();
      if (l.isDead()) leaves.remove(i);
    }
  }

  void display() {
    for (Leaf l : leaves) l.display();
  }

  boolean isDead() {
    return leaves.isEmpty();
  }
}

// ==========================================
// Class: Leaf (Particle)
// ==========================================
class Leaf {
  PVector pos, vel, acc; // 3 essential vectors
  float lifespan, angle, spinSpeed;
  color c;

  Leaf(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(-2, 2), random(-3, 0)); // Initial burst
    acc = new PVector(0, 0);
    
    lifespan = 255;
    angle = random(TWO_PI);
    spinSpeed = random(-0.1, 0.1);
    
    // Autumn palette
    c = color(random(150, 255), random(50, 150), random(0, 50)); 
  }

  void applyForce(PVector f) {
    acc.add(f); 
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0); // Reset per frame

    lifespan -= 1.5; // Fade out
    angle += spinSpeed; // Rotate
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    noStroke();
    fill(c, lifespan);
    
    // Custom drawing: Leaf shape via bezier curves
    beginShape();
    vertex(0, -15);
    bezierVertex(15, -15, 20, 0, 0, 15);
    bezierVertex(-20, 0, -15, -15, 0, -15);
    endShape(CLOSE);
    
    popMatrix();
  }

  boolean isDead() {
    return lifespan < 0 || pos.y > height + 20;
  }
}
