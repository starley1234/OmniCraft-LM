$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 40;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 4;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 6], [42, 6], [42, 34], [80, 34], [80, 40], [0, 40], [0, 34], [38, 34], [38, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
