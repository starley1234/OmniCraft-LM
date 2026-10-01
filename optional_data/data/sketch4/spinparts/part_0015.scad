$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R32
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
rim_r = 32;               // rim radius
rim_w = 7;                // rim axial width
rim_t = 10;               // rim diameter height
hub_r = 10;               // hub radius
web_t = 3;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[4, 0], [10, 0], [10, 3.5], [25, 3.5], [25, 0], [32, 0], [32, 10], [25, 10], [25, 6.5], [10, 6.5], [10, 10], [4, 10]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
