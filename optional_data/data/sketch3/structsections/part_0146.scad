$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 80;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[27.5, 0], [32.5, 0], [32.5, 72], [60, 72], [60, 80], [0, 80], [0, 72], [27.5, 72]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
