$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 6;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 8], [23, 8], [23, 52], [40, 52], [40, 60], [0, 60], [0, 52], [17, 52], [17, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
