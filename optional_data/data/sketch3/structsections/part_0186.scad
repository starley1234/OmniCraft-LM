$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[37, 0], [43, 0], [43, 32], [80, 32], [80, 40], [0, 40], [0, 32], [37, 32]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
