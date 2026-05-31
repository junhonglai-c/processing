# WEEK_06

## Pipeline Architecture
* Function Implementation: I built a custom pipeline function named `applyFilterAndDither()` to stream the image processing operations.
* Edge Extraction: The pipeline first utilizes a 3x3 Laplacian kernel to extract the clean edge contours of the visual frame.
* Binarization: Following the edge extraction, a Floyd-Steinberg dithering algorithm is introduced to force the grayscale pixels into a binarized format via error diffusion.

## Aesthetic Stylization and Inspiration
* Visual Style: The aesthetic is inspired by early American comic books, aiming to simulate the halftone dot patterns characteristic of vintage newspaper printing using cheap ink.
* Creative References: The creative direction draws heavy inspiration from the retro nostalgia of the Game Boy Camera and vintage photo sticker machines.

## Algorithmic Conflicts and Bug Fixes
* Computational Conflict: A severe conflict occurred when combining the two distinct image algorithms. The edge detection calculations sharpened the boundaries but generated extreme negative values or pixel values exceeding 255
* System Crash: Passing these unconstrained values directly into the Floyd-Steinberg algorithm caused the accumulated error calculation to amplify exponentially, completely collapsing the output into chaotic black-and-white noise
* Pixel Constraint Fix: To resolve this issue, I applied `constrain(sumR, 0, 255)` strictly at the end of the inner edge detection loop, ensuring that all grayscale values passed to the dithering stage fall within an absolutely safe range.
* Boundary Protection Fix: Additionally, I implemented strict array out-of-bounds protection (`neighbourIndex < out.pixels.length`) during the error diffusion process, which successfully prevents the program from crashing when handling the final rows and edges of the image data.

> 

https://github.com/user-attachments/assets/51c418ce-d4f6-4f60-8337-b6bd76e57972



