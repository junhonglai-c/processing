# WEEK_10

## Environmental Forces and Class Separation
* Perlin Noise Wind: I generated wind forces using Perlin noise (`noise()`) instead of a purely random function (`random()`) to create smooth, natural, and continuous aerodynamic flows.
* Object-Oriented Architecture: I decoupled the system architecture into two distinct classes: `LeafSystem` and `Leaf`. This explicit separation allows each individual leaf grouping to compute and track its physics calculations independently.

---

## Procedural Geometry and Rotational Physics
* Vector Graphics Contour: For the autumn leaves, I initially considered loading external image assets. However, to keep the system lightweight and scalable, I procedurally rendered the geometric contours of the leaves using Processing's native Bézier curves (`bezierVertex()`).
* Weightless Simulation: By integrating a custom rotation angle (`angle`) and an autonomous rotational speed (`spinSpeed`), the rendering perfectly simulates the weightless, fluttering sensation of leaves drifting downward through the intersecting vectors of gravity and wind.

---

## Memory Management and Particle Depletion
* System Optimization: During testing, I discovered that if leaf particles moving out of bounds or fading to an opacity of 0 were not actively purged, the system would suffer from critical performance degradation and eventually freeze due to memory accumulation.
* Backward Loop Execution: To safely remove dead particles without corrupting the active array indexing or skipping items, I implemented a backward `for` loop (`for (int i = size() - 1; i >= 0; i--)`) to handle the dynamic `remove()` operations seamlessly.

> 

https://github.com/user-attachments/assets/7f7cd9a9-0ea3-45eb-8522-dd1b55bfe5de

