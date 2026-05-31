# Creative Coding Tasks - Processing Implementation

## Task, Part 1: Image Manipulation & Histograms

### 1. RGB Histogram Generation
* **Code Modification**: To fulfill the requirements of Task Part 1, I removed the line `pixels[i] = color(pixelShade);` from the original code[cite: 1]. Instead, I used `image(sample, 0, 0);` at the beginning of the `draw()` function to render the original image[cite: 1].
* **Data Collection & Rendering**: In order to collect and plot the individual Red, Green, and Blue histograms, I utilized three distinct arrays[cite: 1]. While iterating through the pixels, the R, G, and B values are extracted and stored into their respective arrays[cite: 1]. During rendering, lines are drawn using three different colors (Red, Green, and Blue)[cite: 1].
* **Visual Optimization (Alpha Transparency)**: I was concerned that the overlapping lines would be difficult to read, as the Red, Green, and Blue lines would block each other if drawn in the exact same position[cite: 1]. To resolve this, I introduced alpha transparency into the stroke weights during rendering (e.g., `stroke(255, 0, 0, 150)`)[cite: 1].

> <img width="1034" height="1212" alt="图片1" src="https://github.com/user-attachments/assets/00c23159-549a-415b-adab-6bd6b146d3e3" />


---

### 2. Image Scaling & Adaptation
* **Test Material**: I used a photograph I previously took at the White Cliffs[cite: 1].
* **Dimension Mismatch**: I discovered that the dimensions did not match; my image was exceptionally large, causing it to be severely cropped[cite: 1]. Consequently, I chose to manually resize the original image to fit[cite: 1].
* **Future Plan**: Given the opportunity, I will try to dynamically configure the canvas dimensions within the `settings()` function[cite: 1].

> <img width="1034" height="1212" alt="图片2" src="https://github.com/user-attachments/assets/69ae7d89-6c2e-4725-8226-cf798339e943" />
<img width="200" height="272" alt="图片3" src="https://github.com/user-attachments/assets/996f06db-dae6-4527-aa7c-80c163ee1bb4" />



---

### 3. Channel Swapping Effect & Flash Fix
* **Visual Outcome**: After choosing to swap the Red and Blue channels, the original warm-toned color palette shifted entirely into a cool-toned one[cite: 1].
* **Bug Fix (Screen Flickering)**: Because I initially modified `sample.pixels` directly inside the `draw()` loop, the first frame converted RGB to BGR, while the second frame flipped BGR back to RGB, causing the screen to flash erratically[cite: 1].
* **Solution**: To fix this, I moved the channel-swapping process into the `setup()` function so that it executes only once[cite: 1].

> <img width="1600" height="1200" alt="图片4" src="https://github.com/user-attachments/assets/fed9f4c7-76ab-42b1-9bc1-2c68f084abb8" />


---

## Task, Part 2: Pixel Sorting Experiments

### 1. Global Column Sorting
* **Algorithmic Logic**: I implemented a nested double loop[cite: 1]. The outer loop iterates through each column of the image (X-axis), while the inner loop extracts all pixels from that column into an array[cite: 1]. The array is sorted using Processing's built-in `sort()` function before being pushed back into the image[cite: 1].
* **Experimental Purpose**: I wanted to see how much destructive power a pure computational algorithm could inflict on a concrete, representational photograph when applied completely without constraints[cite: 1].

> <img width="600" height="400" alt="图片5" src="https://github.com/user-attachments/assets/1c1482fb-54bf-478f-a95e-ab7ef504e800" />


---

### 2. Threshold-Based Sorting & Boundary Conditions
* **Algorithmic Logic**: I moved away from sorting the entire column and instead utilized a `while` loop to scan the image[cite: 1]. The program only extracts and sorts a segment of pixels when their `brightness()` exceeds a threshold of 180[cite: 1].
* **Debugging & Insights**: While writing the `while` loop, I realized that if I forgot to include `y++` inside the loop body, the program would get stuck on the exact same pixel forever, completely crashing the computer[cite: 1]. This experience gave me a profound appreciation for algorithmic rigor[cite: 1]. Now, every time I write a `while` condition, I am incredibly careful to verify the boundary conditions (such as adding `y < height` to prevent out-of-bounds errors) and the increment variables[cite: 1].

> <img width="600" height="400" alt="图片6" src="https://github.com/user-attachments/assets/85e99aad-ac28-4838-bfb6-143f0221fcb3" />


---

### 3. Custom Selection Sort by Hue
* **Core Implementation**: This is an experimental iteration where I discarded Processing's built-in `sort()` function and manually coded a classic selection sort algorithm from scratch[cite: 1].
* **Modified Comparison Logic**: I altered the comparison logic so that it no longer compares numerical value sizes, but instead compares the `hue()` of the colors[cite: 1]. Standard sorting algorithms typically organize data based on integer values[cite: 1]. However, I was deeply curious to see what would happen if I stretched and pulled a photograph following the natural order of a rainbow[cite: 1].

> <img width="600" height="400" alt="图片7" src="https://github.com/user-attachments/assets/7510f3bd-8c35-46c1-beb0-2d8eac74730b" />

