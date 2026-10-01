$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 40 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // tee width, X
sec_h = 80;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[18, 0], [22, 0], [22, 72], [40, 72], [40, 80], [0, 80], [0, 72], [18, 72]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
