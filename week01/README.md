# WEEK_01

##  Experiments & Iterations

### 1. Replacing RGB Math with `lerpColor()`

Added 3 color variables at the top of the code and replaced the original RGB numerical values with the built-in color palette. Replaced the mathematical formula for calculating red and blue in the `draw()` function with the `lerpColor()` mixer.

<img width="800" height="148" alt="图片1" src="https://github.com/user-attachments/assets/25a3b9c7-cdae-4b38-9905-6ecea15880cd" />


### 2. Modifying Color Variables

Experimented with modifying the colors.

<img width="800" height="146" alt="图片2" src="https://github.com/user-attachments/assets/a271d649-5fa4-4cb6-8820-68e59406988c" />


### 3. Modifying Gradient Direction (Vertical)

Attempted to modify the color direction by finding the `normalizedX` line in the `draw()` function. Changed the reference target from `x` to `y`, and changed `width` to `height`. Also renamed the variable to `normalizedY`.

<img width="800" height="148" alt="图片3" src="https://github.com/user-attachments/assets/f3a89da3-0e98-4376-b290-fb5973d41f73" />


### 4. Diagonal Gradient

Attempted to add `x` and `y` together for the calculation, changing the maximum value to `width + height`. This resulted in a diagonal gradient

<img width="800" height="148" alt="图片4" src="https://github.com/user-attachments/assets/e4aed9b6-59cf-496b-af0e-e0dbae8b206d" />


### 5. Radial Distance Gradient

Switched to measuring the distance from the current pixel to the center of the screen. Introduced the `dist()` distance function as the new basis for calculating the progression.

<img width="800" height="146" alt="图片5" src="https://github.com/user-attachments/assets/32d80a9c-8788-46a0-89c3-0919f4970cb9" />

