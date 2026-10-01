$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 80;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 8], [22.5, 8], [22.5, 72], [40, 72], [40, 80], [0, 80], [0, 72], [17.5, 72], [17.5, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
