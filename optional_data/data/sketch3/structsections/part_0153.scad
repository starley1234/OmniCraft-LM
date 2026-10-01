$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 60 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[0, 0], [60, 0], [60, 5], [32, 5], [32, 55], [60, 55], [60, 60], [0, 60], [0, 55], [28, 55], [28, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
