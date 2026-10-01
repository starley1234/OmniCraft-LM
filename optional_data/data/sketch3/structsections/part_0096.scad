$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 50;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[27.5, 0], [32.5, 0], [32.5, 44], [60, 44], [60, 50], [0, 50], [0, 44], [27.5, 44]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
