$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 80;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 5], [23, 5], [23, 75], [40, 75], [40, 80], [0, 80], [0, 75], [17, 75], [17, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
