$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 5;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[37, 0], [43, 0], [43, 35], [80, 35], [80, 40], [0, 40], [0, 35], [37, 35]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
