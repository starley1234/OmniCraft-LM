$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 60 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[27.5, 0], [32.5, 0], [32.5, 34], [60, 34], [60, 40], [0, 40], [0, 34], [27.5, 34]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
