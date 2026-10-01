$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // channel width, X
sec_h = 50;               // channel height, Y
flange_t = 8;             // flange thickness
web_t = 6;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 8], [6, 8], [6, 42], [40, 42], [40, 50], [0, 50]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
