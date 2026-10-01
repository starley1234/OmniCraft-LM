$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 5;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[27, 0], [33, 0], [33, 55], [60, 55], [60, 60], [0, 60], [0, 55], [27, 55]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
