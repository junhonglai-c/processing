# WEEK_03

## Shape Cycling via Modulo Logic
* Algorithmic Implementation: I utilized the code `int shapeType = counter % 3;`. No matter how large the `counter` variable grows, the remainder when divided by 3 will always cycle strictly through 0, 1, and 2.
* State Switching: I used these three remainders as conditional switches (`if`/`else` statements) to trigger the rendering of circles, rotated squares, and triangles. Each shape type was assigned red, green, and blue as its primary color tone, respectively.

> <img width="1600" height="1600" alt="图片1" src="https://github.com/user-attachments/assets/f7231894-934f-4e1f-aa7c-9a6f2838da65" />

---

## Coordinate Simplification via Matrix Manipulation
* Matrix Operations: Through case studies, I learned how to use `pushMatrix()` and `translate()` to dynamically move the canvas origin.
* Efficiency Gains: Mastering this technique was absolutely critical. Calculating the three absolute vertex coordinates for every individual triangle manually would be incredibly tedious. Translating the origin to the target position and rendering shapes relative to `(0,0)` made the mathematical process significantly simpler.

---

## Spatial Compression and Blend Modes
* Grid Disruption: After the initial implementation, I intentionally configured the shape dimensions (100px) to be larger than the actual grid spacing (50px).
* Interlocking Textures: This forced spatial compression, combined with the activation of the `DIFFERENCE` blend mode, caused the individual, isolated geometric forms to overlap and collapse into a highly complex, interlocking visual texture.

><img width="1600" height="1600" alt="图片2" src="https://github.com/user-attachments/assets/64bb41c9-97a4-4e21-9931-2c94c1fa1c7b" />
