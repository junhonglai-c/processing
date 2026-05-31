# Endless Runner Physics and Input Mechanics

## Physics Engine and Collision Mechanics
* Core Forces: The system applies two primary physical forces: a global downward vector (`gravity`) accumulated every frame, and an instantaneous upward vector (`jumpForce`) applied to the player upon pressing the jump key.
* Platform Interaction: Foundational platformer mechanics are achieved by procedurally generating leftward-scrolling rainbow platform instances within the `draw()` loop. The system continuously checks for intersections between the unicorn's bottom boundary and the top edge of the rainbow platforms to handle landing and physics state resets.

---

## Nostalgic Inspiration and Input Mapping
* Creative Reference: The visual aesthetic and core concept draw heavy inspiration from the classic childhood web game *Robot Unicorn Attack*.
* Control Scheme: To capture the authentic feel of the original title, I faithfully replicated its signature control layout, implementing the iconic "Z to Jump, X to Dash" input logic.

---

## Dash Physics and Scrolling Conflict
* Design Challenge: A critical conflict arose between the dash physics and the auto-scrolling engine. In a typical endless runner game, the background scrolls leftward while the player's X-coordinate remains locked to a fixed position on the left side of the screen (e.g., `x = 150`). 
* Visual Limitation: Simply increasing the background scroll speed during a dash fails to deliver a strong sense of speed or physical impact.

---

## Solution: Forward Thrust and Elastic Recovery
* Dynamic Forward Thrust: To maximize the visual impact of the action, triggering a dash applies a rightward horizontal velocity (`vel.x`) directly to the character. This allows the unicorn to physically surge forward relative to the camera viewport.
* Smooth Spring Recovery: Once the `dashTimer` expires, the system applies a subtle negative horizontal force (-0.5 counter-spring effect). This pulls the character backward, allowing the unicorn to smoothly and gradually ease back into its default anchor position at `x = 150`.

> [Drag and drop your endless runner gameplay video or animation here]
