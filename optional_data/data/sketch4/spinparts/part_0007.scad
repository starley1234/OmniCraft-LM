$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R28
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 28;               // rim radius
rim_w = 7;                // rim axial width
rim_t = 12;               // rim diameter height
hub_r = 10;               // hub radius
web_t = 4;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[6, 0], [10, 0], [10, 4], [21, 4], [21, 0], [28, 0], [28, 12], [21, 12], [21, 8], [10, 8], [10, 12], [6, 12]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
