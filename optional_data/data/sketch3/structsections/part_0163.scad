$fn = 32;

// ----------------------------------------------------------------------
// Structural section: angle 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // leg width, X
sec_h = 60;               // leg height, Y
flange_t = 5;             // leg thickness
plate_t = 50;             // cut length, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 5], [5, 5], [5, 60], [0, 60]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
