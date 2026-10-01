$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 80;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[38, 0], [42, 0], [42, 72], [80, 72], [80, 80], [0, 80], [0, 72], [38, 72]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
