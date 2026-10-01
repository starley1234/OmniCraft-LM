$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 80;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 8], [43, 8], [43, 72], [80, 72], [80, 80], [0, 80], [0, 72], [37, 72], [37, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
