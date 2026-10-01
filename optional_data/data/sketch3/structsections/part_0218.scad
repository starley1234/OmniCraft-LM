$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 40;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 8], [42, 8], [42, 32], [80, 32], [80, 40], [0, 40], [0, 32], [38, 32], [38, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
