$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R36
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
rim_r = 36;               // rim radius
rim_w = 7;                // rim axial width
rim_t = 12;               // rim diameter height
hub_r = 8;                // hub radius
web_t = 3;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[4, 0], [8, 0], [8, 4.5], [29, 4.5], [29, 0], [36, 0], [36, 12], [29, 12], [29, 7.5], [8, 7.5], [8, 12], [4, 12]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
