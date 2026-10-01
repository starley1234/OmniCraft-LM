$fn = 32;

// ----------------------------------------------------------------------
// Structural section: angle 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // leg width, X
sec_h = 40;               // leg height, Y
flange_t = 8;             // leg thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 8], [8, 8], [8, 40], [0, 40]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
