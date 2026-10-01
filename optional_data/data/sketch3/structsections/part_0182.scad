$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 40;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 6;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 8], [23, 8], [23, 32], [40, 32], [40, 40], [0, 40], [0, 32], [17, 32], [17, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
