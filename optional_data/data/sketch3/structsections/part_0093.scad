$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 5], [43, 5], [43, 55], [80, 55], [80, 60], [0, 60], [0, 55], [37, 55], [37, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
