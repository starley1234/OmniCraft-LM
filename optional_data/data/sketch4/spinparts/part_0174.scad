$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R36
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 36;               // rim radius
rim_w = 8;                // rim axial width
rim_t = 10;               // rim diameter height
hub_r = 12;               // hub radius
web_t = 3;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[6, 0], [12, 0], [12, 3.5], [28, 3.5], [28, 0], [36, 0], [36, 10], [28, 10], [28, 6.5], [12, 6.5], [12, 10], [6, 10]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
