$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 50 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // channel width, X
sec_h = 40;               // channel height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [50, 0], [50, 5], [6, 5], [6, 35], [50, 35], [50, 40], [0, 40]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
