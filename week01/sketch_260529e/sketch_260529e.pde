color c1, c2, c3;

void setup() {
  size(400, 300);
  
  // 保持刚才暖暖的画廊色
  c1 = color(43, 25, 61);    // 最外圈：暗紫红
  c2 = color(204, 88, 81);   // 中间圈：陶土红
  c3 = color(235, 178, 107); // 最中心：沙丘黄
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      
      // 1. 量出当前点 (x,y) 到中心点 (width/2, height/2) 的距离
      float d = dist(x, y, width/2, height/2);
      
      // 2. 算出最大距离（从中心到左上角顶点）
      float maxDist = dist(0, 0, width/2, height/2);
      
      // 3. 将距离转换为 0-1 的进度
      float percent = map(d, 0, maxDist, 0, 1); 
      
      color c;
      // 注意：距离中心越近 (percent越小)，我们用亮色 c3；越远用暗色 c1
      if (percent < 0.5) {
        c = lerpColor(c3, c2, map(percent, 0, 0.5, 0, 1));
      } else {
        c = lerpColor(c2, c1, map(percent, 0.5, 1, 0, 1));
      }

      pixels[x + y * width] = c; 
    }
  }
  updatePixels();
}
