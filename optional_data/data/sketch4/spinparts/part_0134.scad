$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R32
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
rim_r = 32;               // rim radius
rim_w = 8;                // rim axial width
rim_t = 10;               // rim diameter height
hub_r = 9;                // hub radius
web_t = 4;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[5, 0], [9, 0], [9, 3], [24, 3], [24, 0], [32, 0], [32, 10], [24, 10], [24, 7], [9, 7], [9, 10], [5, 10]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
