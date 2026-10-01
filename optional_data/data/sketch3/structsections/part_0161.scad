$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[27, 0], [33, 0], [33, 52], [60, 52], [60, 60], [0, 60], [0, 52], [27, 52]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
