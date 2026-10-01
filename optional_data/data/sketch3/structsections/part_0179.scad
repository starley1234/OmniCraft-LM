$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 60 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // section width, X
sec_h = 40;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 5;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 6], [32.5, 6], [32.5, 34], [60, 34], [60, 40], [0, 40], [0, 34], [27.5, 34], [27.5, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
