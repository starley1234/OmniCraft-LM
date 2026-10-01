$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 80;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[37.5, 0], [42.5, 0], [42.5, 74], [80, 74], [80, 80], [0, 80], [0, 74], [37.5, 74]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
