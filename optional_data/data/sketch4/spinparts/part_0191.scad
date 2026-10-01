$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: flanged bushing R20
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
flange_r = 20;            // flange radius
flange_h = 5;             // flange thickness
sleeve_r = 10;            // sleeve radius
total_h = 20;             // overall height
revolve_angle = 360;      // revolve sweep, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

bore_d = 2 * bore_r;
flange_d = 2 * flange_r;
sleeve_d = 2 * sleeve_r;

profile = [[5, 0], [20, 0], [20, 5], [10, 5], [10, 20], [5, 20]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
