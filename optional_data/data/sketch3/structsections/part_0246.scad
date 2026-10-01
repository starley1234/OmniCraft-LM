$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 60 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // channel width, X
sec_h = 80;               // channel height, Y
flange_t = 6;             // flange thickness
web_t = 6;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [60, 0], [60, 6], [6, 6], [6, 74], [60, 74], [60, 80], [0, 80]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
