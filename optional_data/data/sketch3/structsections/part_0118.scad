$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 80;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 6;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 6], [43, 6], [43, 74], [80, 74], [80, 80], [0, 80], [0, 74], [37, 74], [37, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
