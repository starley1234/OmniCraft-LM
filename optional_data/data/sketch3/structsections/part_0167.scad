$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[23, 0], [27, 0], [27, 34], [50, 34], [50, 40], [0, 40], [0, 34], [23, 34]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
