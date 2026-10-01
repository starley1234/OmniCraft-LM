$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R32
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 32;               // rim radius
rim_w = 6;                // rim axial width
rim_t = 12;               // rim diameter height
hub_r = 11;               // hub radius
web_t = 3;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[6, 0], [11, 0], [11, 4.5], [26, 4.5], [26, 0], [32, 0], [32, 12], [26, 12], [26, 7.5], [11, 7.5], [11, 12], [6, 12]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
