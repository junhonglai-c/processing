import processing.video.*;

Capture cam;
PImage processedImage;
PImage[] comicReel = new PImage[10]; // Frame array
int saveCount = 0;

// Edge detection kernel
float[][] edgeKernel = {
  { -1, -1, -1 }, 
  { -1,  8, -1 }, 
  { -1, -1, -1 }
};

void setup() {
  size(1080, 720); 
  
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("No camera detected!");
    exit();
  } else {
    cam = new Capture(this, 640, 480, cameras[0]);
    cam.start();
  }
}

void draw() {
  background(240); 

  if (cam.available()) {
    cam.read();
  }

  // Apply filters
  processedImage = applyFilterAndDither(cam);

  // Main viewfinder
  int mainX = (width - 640) / 2;
  int mainY = 30;
  image(processedImage, mainX, mainY); 
  
  noFill();
  stroke(0);
  strokeWeight(5);
  rect(mainX, mainY, 640, 480); 
  
  // Film strip
  drawComicReel(50, 540, 980, 130); 

  // UI
  fill(0);
  textSize(16);
  textAlign(CENTER);
  if (saveCount < 10) {
    text("Press 'S' to capture frame (" + saveCount + "/10)", width/2, height - 20);
  } else {
    fill(200, 0, 0);
    text("Film strip full! Saved as FINAL_COMIC_REEL.jpg", width/2, height - 20);
  }
}

void drawComicReel(int x, int y, int w, int h) {
  fill(255);
  stroke(0);
  strokeWeight(3);
  rect(x, y, w, h); 
  
  int margin = 10;
  int thumbW = (w - margin * 11) / 10; 
  int thumbH = h - margin * 2;
  
  for (int i = 0; i < 10; i++) {
    int thumbX = x + margin + i * (thumbW + margin);
    int thumbY = y + margin;
  
    if (comicReel[i] != null) {
      image(comicReel[i], thumbX, thumbY, thumbW, thumbH);
    } else {
      fill(220); 
      noStroke();
      rect(thumbX, thumbY, thumbW, thumbH);
    }
    
    noFill();
    stroke(0);
    strokeWeight(2);
    rect(thumbX, thumbY, thumbW, thumbH);
  }
}

void keyPressed() {
  if ((key == 's' || key == 'S') && saveCount < 10) {
    comicReel[saveCount] = processedImage.get();
    saveCount++;
    
    saveFrame("comic_page_progress_####.jpg");
    
    if (saveCount == 10) {
      saveFrame("FINAL_COMIC_REEL.jpg");
    }
  }
}

// Convolution and Floyd-Steinberg Dithering
PImage applyFilterAndDither(PImage input) {
  PImage out = createImage(input.width, input.height, RGB);
  input.loadPixels();
  out.loadPixels();
  
  // Step 1: Convolution (Edge Detection)
  for (int y = 1; y < input.height-1; y++) {
    for (int x = 1; x < input.width-1; x++) {
      float sumR = 0;
      for (int offsetY = -1; offsetY <= 1; offsetY++) {
        for (int offsetX= -1; offsetX <= 1; offsetX++) {
          int neighbourIndex = (y + offsetY) * input.width + (x + offsetX);
          sumR += red(input.pixels[neighbourIndex]) * edgeKernel[offsetY+1][offsetX+1];
        }
      }
      out.pixels[y * input.width + x] = color(constrain(sumR, 0, 255));
    }
  }
  
  // Step 2: Floyd-Steinberg Dithering
  for (int y = 0; y < out.height; y++) {
    for (int x = 0; x < out.width; x++) {
      int i = x + y * out.width;
      float greyValue = red(out.pixels[i]);
      
      float newPixelValue = (greyValue > 127) ? 255 : 0; 
      float error = greyValue - newPixelValue;
      out.pixels[i] = color(newPixelValue);
      
      // Error diffusion logic
      int[] offsets = { 1, out.width - 1, out.width, out.width + 1 };
      float[] ditherRatios = { 7/16.0, 3/16.0, 5/16.0, 1/16.0 };
      
      for (int j = 0; j < 4; j++) {
        int neighbourIndex = i + offsets[j];
        // Ensure index is within bounds before applying error
        if (neighbourIndex >= 0 && neighbourIndex < out.pixels.length) { 
          float neighbourGrey = red(out.pixels[neighbourIndex]);
          out.pixels[neighbourIndex] = color(constrain(neighbourGrey + (error * ditherRatios[j]), 0, 255));
        }
      }
    }
  }
  out.updatePixels();
  return out;
}
