$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[23, 0], [27, 0], [27, 54], [50, 54], [50, 60], [0, 60], [0, 54], [23, 54]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
