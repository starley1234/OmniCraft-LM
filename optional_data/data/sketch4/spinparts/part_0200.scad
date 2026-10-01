$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R32
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 32;               // rim radius
rim_w = 7;                // rim axial width
rim_t = 12;               // rim diameter height
hub_r = 12;               // hub radius
web_t = 4;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[6, 0], [12, 0], [12, 4], [25, 4], [25, 0], [32, 0], [32, 12], [25, 12], [25, 8], [12, 8], [12, 12], [6, 12]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
