$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[38, 0], [42, 0], [42, 34], [80, 34], [80, 40], [0, 40], [0, 34], [38, 34]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
