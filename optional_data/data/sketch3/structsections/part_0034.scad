$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 50 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // section width, X
sec_h = 80;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 5], [27.5, 5], [27.5, 75], [50, 75], [50, 80], [0, 80], [0, 75], [22.5, 75], [22.5, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
