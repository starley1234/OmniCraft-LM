$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 80;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[37, 0], [43, 0], [43, 72], [80, 72], [80, 80], [0, 80], [0, 72], [37, 72]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
