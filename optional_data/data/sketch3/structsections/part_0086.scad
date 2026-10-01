$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 50;               // tee height, Y
flange_t = 5;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[22, 0], [28, 0], [28, 45], [50, 45], [50, 50], [0, 50], [0, 45], [22, 45]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
