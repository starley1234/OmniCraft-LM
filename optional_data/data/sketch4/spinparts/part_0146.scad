$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: handwheel R36
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
rim_r = 36;               // rim radius
rim_w = 6;                // rim axial width
rim_t = 10;               // rim diameter height
hub_r = 8;                // hub radius
web_t = 3;                // web thickness
revolve_angle = 360;      // revolve sweep, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
hub_d = 2 * hub_r;

profile = [[4, 0], [8, 0], [8, 3.5], [30, 3.5], [30, 0], [36, 0], [36, 10], [30, 10], [30, 6.5], [8, 6.5], [8, 10], [4, 10]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
