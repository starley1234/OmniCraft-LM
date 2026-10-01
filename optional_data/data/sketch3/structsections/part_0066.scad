$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 8], [42, 8], [42, 42], [80, 42], [80, 50], [0, 50], [0, 42], [38, 42], [38, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
