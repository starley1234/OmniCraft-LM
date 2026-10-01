$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R28
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
rim_r = 28;               // rim radius
rim_w = 8;                // rim axial width
rim_t = 10;               // rim diameter height
hub_r = 11;               // hub radius
web_t = 4;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[5, 0], [11, 0], [11, 3], [20, 3], [20, 0], [28, 0], [28, 10], [20, 10], [20, 7], [11, 7], [11, 10], [5, 10]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
