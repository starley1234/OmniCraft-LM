$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 80;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[27, 0], [33, 0], [33, 74], [60, 74], [60, 80], [0, 80], [0, 74], [27, 74]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
