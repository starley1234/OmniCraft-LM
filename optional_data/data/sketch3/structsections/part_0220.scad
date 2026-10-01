$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 60 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 5], [33, 5], [33, 55], [60, 55], [60, 60], [0, 60], [0, 55], [27, 55], [27, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
