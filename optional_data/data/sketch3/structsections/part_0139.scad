$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 5], [42, 5], [42, 45], [80, 45], [80, 50], [0, 50], [0, 45], [38, 45], [38, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
