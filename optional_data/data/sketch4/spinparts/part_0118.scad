$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R28
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 28;               // rim radius
rim_w = 6;                // rim axial width
rim_t = 10;               // rim diameter height
hub_r = 10;               // hub radius
web_t = 4;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[6, 0], [10, 0], [10, 3], [22, 3], [22, 0], [28, 0], [28, 10], [22, 10], [22, 7], [10, 7], [10, 10], [6, 10]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
