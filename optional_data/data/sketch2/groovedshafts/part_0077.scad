$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R5
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
outer_r = 7.5;            // outer radius of the body
total_h = 36;             // overall height, Z
wall = 2.5;               // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.1;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[5, 0], [7.5, 0], [7.5, 10.5], [6.4, 10.5], [6.4, 13.5], [7.5, 13.5], [7.5, 22.5], [6.4, 22.5], [6.4, 25.5], [7.5, 25.5], [7.5, 36], [5, 36]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
