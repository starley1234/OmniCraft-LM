$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R28
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
rim_r = 28;               // rim radius
rim_w = 6;                // rim axial width
rim_t = 12;               // rim diameter height
hub_r = 9;                // hub radius
web_t = 4;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[5, 0], [9, 0], [9, 4], [22, 4], [22, 0], [28, 0], [28, 12], [22, 12], [22, 8], [9, 8], [9, 12], [5, 12]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
