$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 50;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[23, 0], [27, 0], [27, 44], [50, 44], [50, 50], [0, 50], [0, 44], [23, 44]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
