# WEEK_02

## Task, Part 1

### 1. RGB Histogram Generation
* Code Modification: To fulfill the requirements of Task Part 1, I removed the line `pixels[i] = color(pixelShade);` from the original code. Instead, I used `image(sample, 0, 0);` at the beginning of the `draw()` function to render the original image.
* Data Collection & Rendering: In order to collect and plot the individual Red, Green, and Blue histograms, I utilized three distinct arrays. While iterating through the pixels, the R, G, and B values are extracted and stored into their respective arrays. During rendering, lines are drawn using three different colors (Red, Green, and Blue).
* Visual Optimization (Alpha Transparency): I was concerned that the overlapping lines would be difficult to read, as the Red, Green, and Blue lines would block each other if drawn in the exact same position. To resolve this, I introduced alpha transparency into the stroke weights during rendering (e.g., `stroke(255, 0, 0, 150)`).

> <img width="1034" height="1212" alt="图片1" src="https://github.com/user-attachments/assets/1843a63a-a976-44c0-83f1-021bd6aa999a" />


---

### 2. Image Scaling & Adaptation
* Test Material: I used a photograph I previously took at the White Cliffs.
* Dimension Mismatch: I discovered that the dimensions did not match; my image was exceptionally large, causing it to be severely cropped. Consequently, I chose to manually resize the original image to fit.
* Future Plan: Given the opportunity, I will try to dynamically configure the canvas dimensions within the `settings()` function.

><img width="1034" height="1212" alt="图片2" src="https://github.com/user-attachments/assets/630672ce-36e0-4b27-b266-4c4e1fe075b7" />
<img width="200" height="272" alt="图片3" src="https://github.com/user-attachments/assets/d3950455-1ae7-4f93-96fd-aa0fa668582e" />



---

### 3. Channel Swapping Effect & Flash Fix
* Visual Outcome: After choosing to swap the Red and Blue channels, the original warm-toned color palette shifted entirely into a cool-toned one.
* Bug Fix (Screen Flickering): Because I initially modified `sample.pixels` directly inside the `draw()` loop, the first frame converted RGB to BGR, while the second frame flipped BGR back to RGB, causing the screen to flash erratically.
* Solution: To fix this, I moved the channel-swapping process into the `setup()` function so that it executes only once.

> <img width="1600" height="1200" alt="图片4" src="https://github.com/user-attachments/assets/8017f70e-1d37-44a4-9366-996285c9a1d4" />


---

## Task, Part 2

### 1. Global Column Sorting
* Algorithmic Logic: I implemented a nested double loop. The outer loop iterates through each column of the image (X-axis), while the inner loop extracts all pixels from that column into an array. The array is sorted using Processing's built-in `sort()` function before being pushed back into the image.
* Experimental Purpose: I wanted to see how much destructive power a pure computational algorithm could inflict on a concrete, representational photograph when applied completely without constraints.

> <img width="600" height="400" alt="图片5" src="https://github.com/user-attachments/assets/42410780-4a9d-407f-aeb9-df8aca02e6dc" />


---

### 2. Threshold-Based Sorting & Boundary Conditions
* Algorithmic Logic: I moved away from sorting the entire column and instead utilized a `while` loop to scan the image. The program only extracts and sorts a segment of pixels when their `brightness()` exceeds a threshold of 180.
* Debugging & Insights: While writing the `while` loop, I realized that if I forgot to include `y++` inside the loop body, the program would get stuck on the exact same pixel forever, completely crashing the computer. This experience gave me a profound appreciation for algorithmic rigor. Now, every time I write a `while` condition, I am incredibly careful to verify the boundary conditions (such as adding `y < height` to prevent out-of-bounds errors) and the increment variables.

><img width="600" height="400" alt="图片6" src="https://github.com/user-attachments/assets/c99a835e-2980-49d1-a3e1-dc71382f6c07" />


---

### 3. Custom Selection Sort by Hue
* Core Implementation: This is an experimental iteration where I discarded Processing's built-in `sort()` function and manually coded a classic selection sort algorithm from scratch.
* Modified Comparison Logic: I altered the comparison logic so that it no longer compares numerical value sizes, but instead compares the `hue()` of the colors. Standard sorting algorithms typically organize data based on integer values. However, I was deeply curious to see what would happen if I stretched and pulled a photograph following the natural order of a rainbow.

><img width="600" height="400" alt="图片7" src="https://github.com/user-attachments/assets/fafd2325-e5c2-42ca-8a21-27113f725340" />
