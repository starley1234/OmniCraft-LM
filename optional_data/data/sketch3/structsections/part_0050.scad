$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 50;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[37.5, 0], [42.5, 0], [42.5, 42], [80, 42], [80, 50], [0, 50], [0, 42], [37.5, 42]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
