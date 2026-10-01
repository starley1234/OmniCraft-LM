$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 60 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 6], [32, 6], [32, 54], [60, 54], [60, 60], [0, 60], [0, 54], [28, 54], [28, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
