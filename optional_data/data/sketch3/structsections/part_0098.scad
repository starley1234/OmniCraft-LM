$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 5], [28, 5], [28, 45], [50, 45], [50, 50], [0, 50], [0, 45], [22, 45], [22, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
