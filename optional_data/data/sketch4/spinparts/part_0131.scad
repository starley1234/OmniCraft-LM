$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: flanged bushing R18
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
flange_r = 18;            // flange radius
flange_h = 4;             // flange thickness
sleeve_r = 12;            // sleeve radius
total_h = 28;             // overall height
revolve_angle = 360;      // revolve sweep, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bore_d = 2 * bore_r;
flange_d = 2 * flange_r;
sleeve_d = 2 * sleeve_r;

profile = [[4, 0], [18, 0], [18, 4], [12, 4], [12, 28], [4, 28]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
