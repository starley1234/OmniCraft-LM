$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 5;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[17.5, 0], [22.5, 0], [22.5, 35], [40, 35], [40, 40], [0, 40], [0, 35], [17.5, 35]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
