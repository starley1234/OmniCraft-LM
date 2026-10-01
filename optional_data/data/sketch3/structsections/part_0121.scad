$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // section width, X
sec_h = 50;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 5;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 6], [27.5, 6], [27.5, 44], [50, 44], [50, 50], [0, 50], [0, 44], [22.5, 44], [22.5, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
