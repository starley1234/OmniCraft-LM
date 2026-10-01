$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[27, 0], [33, 0], [33, 32], [60, 32], [60, 40], [0, 40], [0, 32], [27, 32]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
