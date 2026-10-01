$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // tee width, X
sec_h = 50;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[22.5, 0], [27.5, 0], [27.5, 44], [50, 44], [50, 50], [0, 50], [0, 44], [22.5, 44]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
