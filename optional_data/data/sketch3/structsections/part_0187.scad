$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 8], [22, 8], [22, 42], [40, 42], [40, 50], [0, 50], [0, 42], [18, 42], [18, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
