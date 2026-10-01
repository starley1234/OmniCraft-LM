$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[22.5, 0], [27.5, 0], [27.5, 32], [50, 32], [50, 40], [0, 40], [0, 32], [22.5, 32]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
