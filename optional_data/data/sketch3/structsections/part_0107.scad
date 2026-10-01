$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 80;               // tee height, Y
flange_t = 5;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[22.5, 0], [27.5, 0], [27.5, 75], [50, 75], [50, 80], [0, 80], [0, 75], [22.5, 75]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
