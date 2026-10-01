$fn = 32;

// ----------------------------------------------------------------------
// Structural section: angle 60 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // leg width, X
sec_h = 50;               // leg height, Y
flange_t = 6;             // leg thickness
plate_t = 40;             // cut length, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [60, 0], [60, 6], [6, 6], [6, 50], [0, 50]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
