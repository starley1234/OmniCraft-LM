$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 60 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 5], [33, 5], [33, 45], [60, 45], [60, 50], [0, 50], [0, 45], [27, 45], [27, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
