PImage sample;

void setup() {
  size(517, 606); // 注意：如果换了图片，这个尺寸最好改成图片的实际尺寸
  sample = loadImage("sample.jpg");
}

void draw() {
  // 1. 直接画出原图，保留彩色
  image(sample, 0, 0);

  // 2. 准备三个计分板（直方图数组）
  int[] histR = new int[256];
  int[] histG = new int[256];
  int[] histB = new int[256];
  
  sample.loadPixels();
  
  // 3. 统计像素
  for (int i = 0; i < sample.pixels.length; i++) {
    color c = sample.pixels[i];
    
    // 提取单通道数值并取整
    int r = int(red(c));
    int g = int(green(c));
    int b = int(blue(c));
    
    // 分别记录到各自的数组中
    histR[r]++;
    histG[g]++;
    histB[b]++;
  }  

  // 找到三个数组中的最大值，用于统一计算高度比例
  int maxR = max(histR);
  int maxG = max(histG);
  int maxB = max(histB);
  // 取三个最大值中最大的那个，确保所有的线都不会画出屏幕
  int overallMax = max(max(maxR, maxG), maxB);

  // 4. 绘制直方图
  for (int i = 0; i < 256; i++) {
    // 画红色直方图 (加入半透明度 150 防止遮挡)
    stroke(255, 0, 0, 150); 
    float startR = map(histR[i], 0, overallMax, height, height - 150);
    line(i * 2, startR, i * 2, height); // i*2 是为了把 256 的宽度拉长一点，方便观察

    // 画绿色直方图
    stroke(0, 255, 0, 150); 
    float startG = map(histG[i], 0, overallMax, height, height - 150);
    line(i * 2, startG, i * 2, height);

    // 画蓝色直方图
    stroke(0, 0, 255, 150); 
    float startB = map(histB[i], 0, overallMax, height, height - 150);
    line(i * 2, startB, i * 2, height);
  }
}
