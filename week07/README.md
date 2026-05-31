# WEEK_07

## Oscillator Integration and Visual Mapping
* Dynamic Animation: To transform the static pattern from Week 3 into a dynamic animation, I introduced `SinOsc` from the `processing.sound` library as a Low-Frequency Oscillator (LFO).
* Value Extraction: Inside the `draw()` loop, I extracted sine wave values replicating the oscillator's output, creating a smooth fluctuation between -1 and 1.
* Dual-Domain Mapping: I used the `map()` function to map this raw value across two distinct visual domains simultaneously:
  * Dimension Domain: Mapping -1 to 1 into a shape size range of 60 to 140 pixels.
  * Rotation Domain: Mapping -1 to 1 into a rotation range of 0 to 180 degrees (converted to radians).
* Visual Outcome: Over time, the entire grid matrix expands and contracts like a breathing cycle, and the internal squares rotate accordingly.



https://github.com/user-attachments/assets/d7a12e24-47ff-4a30-9a4c-a49ee7de9c48


---

## Technical Pitfalls and Cross-Thread Optimization
* Reading Limitations: During implementation, the biggest technical trap was the limitation of reading the oscillator's real-time output. In Processing's Sound library, `SinOsc` is primarily designed for audio output to the sound card. Attempting to directly fetch its instantaneous amplitude is unreliable and causes severe screen flickering.
* Solution: While I conceptually declared and established an LFO, I bypassed the audio buffer for the actual visual driving logic. Instead, I utilized the underlying mathematical function `sin(frameCount * 0.02)`, which is perfectly synchronized with the LFO's frequency.
* Optimization Results: This approach guaranteed absolute smoothness in the waveform data, successfully preventing screen tearing and flickering caused by cross-thread audio buffer reads.

> 



https://github.com/user-attachments/assets/e9cabbf6-edf8-4a09-a5d0-cbe9303d8c6c



