$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R28
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 28;               // rim radius
rim_w = 7;                // rim axial width
rim_t = 10;               // rim diameter height
hub_r = 11;               // hub radius
web_t = 3;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[6, 0], [11, 0], [11, 3.5], [21, 3.5], [21, 0], [28, 0], [28, 10], [21, 10], [21, 6.5], [11, 6.5], [11, 10], [6, 10]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
