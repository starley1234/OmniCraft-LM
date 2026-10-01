$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [80, 0], [80, 8], [42.5, 8], [42.5, 52], [80, 52], [80, 60], [0, 60], [0, 52], [37.5, 52], [37.5, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
