$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 50 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // section width, X
sec_h = 40;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 5], [27, 5], [27, 35], [50, 35], [50, 40], [0, 40], [0, 35], [23, 35], [23, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
