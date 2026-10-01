$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 50 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 8;             // flange thickness
web_t = 5;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 8], [27.5, 8], [27.5, 52], [50, 52], [50, 60], [0, 60], [0, 52], [22.5, 52], [22.5, 8], [0, 8]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
