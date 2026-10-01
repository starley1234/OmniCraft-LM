$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[17, 0], [23, 0], [23, 34], [40, 34], [40, 40], [0, 40], [0, 34], [17, 34]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
