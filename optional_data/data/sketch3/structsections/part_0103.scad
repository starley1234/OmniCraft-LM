$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 5], [23, 5], [23, 55], [40, 55], [40, 60], [0, 60], [0, 55], [17, 55], [17, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
