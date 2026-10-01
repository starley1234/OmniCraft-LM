$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[28, 0], [32, 0], [32, 54], [60, 54], [60, 60], [0, 60], [0, 54], [28, 54]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
