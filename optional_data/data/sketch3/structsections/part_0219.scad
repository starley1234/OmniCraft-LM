$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 40;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [80, 0], [80, 5], [43, 5], [43, 35], [80, 35], [80, 40], [0, 40], [0, 35], [37, 35], [37, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
