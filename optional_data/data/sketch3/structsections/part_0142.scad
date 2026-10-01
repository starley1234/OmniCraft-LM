$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 5;             // top flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[18, 0], [22, 0], [22, 55], [40, 55], [40, 60], [0, 60], [0, 55], [18, 55]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
