$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 40;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [80, 0], [80, 6], [42.5, 6], [42.5, 34], [80, 34], [80, 40], [0, 40], [0, 34], [37.5, 34], [37.5, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
