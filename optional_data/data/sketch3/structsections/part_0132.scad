$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 50;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[27, 0], [33, 0], [33, 42], [60, 42], [60, 50], [0, 50], [0, 42], [27, 42]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
