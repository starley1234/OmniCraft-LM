$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 8], [27, 8], [27, 42], [50, 42], [50, 50], [0, 50], [0, 42], [23, 42], [23, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
