$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 60 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 8], [33, 8], [33, 42], [60, 42], [60, 50], [0, 50], [0, 42], [27, 42], [27, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
