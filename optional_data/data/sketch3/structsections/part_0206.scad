$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[0, 0], [80, 0], [80, 5], [42, 5], [42, 55], [80, 55], [80, 60], [0, 60], [0, 55], [38, 55], [38, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
