$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 50 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // section width, X
sec_h = 80;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 5;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 8], [27.5, 8], [27.5, 72], [50, 72], [50, 80], [0, 80], [0, 72], [22.5, 72], [22.5, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
