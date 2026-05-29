// 1. 在最外层准备三个颜色的“空碗”
color c1, c2, c3;

void setup() {
  size(400, 300);
  
  // 微调后的颜色（变成了暖色调）
  c1 = color(43, 25, 61);    // 暗紫红
  c2 = color(204, 88, 81);   // 陶土红
  c3 = color(235, 178, 107); // 沙丘黄
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      
// 看 Y 坐标，Y 越大（越往下），进度越深
      float normalizedY = map(y, 0, height - 1, 0, 1); 
      
      color c;
      if (normalizedY < 0.5) {
        c = lerpColor(c1, c2, map(normalizedY, 0, 0.5, 0, 1));
      } else {
        c = lerpColor(c2, c3, map(normalizedY, 0.5, 1, 0, 1));
      }

      pixels[x + y * width] = c; 
    }
  }
  updatePixels();
}
