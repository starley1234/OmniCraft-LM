$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[22.5, 0], [27.5, 0], [27.5, 52], [50, 52], [50, 60], [0, 60], [0, 52], [22.5, 52]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
