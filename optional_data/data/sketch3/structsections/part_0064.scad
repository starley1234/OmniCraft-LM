$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 5;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [80, 0], [80, 5], [42.5, 5], [42.5, 45], [80, 45], [80, 50], [0, 50], [0, 45], [37.5, 45], [37.5, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
