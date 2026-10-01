$fn = 32;

// ----------------------------------------------------------------------
// Structural section: angle 50 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // leg width, X
sec_h = 60;               // leg height, Y
flange_t = 8;             // leg thickness
plate_t = 80;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [50, 0], [50, 8], [8, 8], [8, 60], [0, 60]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
