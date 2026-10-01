$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R36
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 36;               // rim radius
rim_w = 8;                // rim axial width
rim_t = 12;               // rim diameter height
hub_r = 10;               // hub radius
web_t = 4;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[6, 0], [10, 0], [10, 4], [28, 4], [28, 0], [36, 0], [36, 12], [28, 12], [28, 8], [10, 8], [10, 12], [6, 12]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
