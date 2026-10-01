$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // channel width, X
sec_h = 50;               // channel height, Y
flange_t = 6;             // flange thickness
web_t = 4;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 6], [4, 6], [4, 44], [40, 44], [40, 50], [0, 50]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
