$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 60 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // section width, X
sec_h = 80;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 8], [32.5, 8], [32.5, 72], [60, 72], [60, 80], [0, 80], [0, 72], [27.5, 72], [27.5, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
