$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 40;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[37.5, 0], [42.5, 0], [42.5, 34], [80, 34], [80, 40], [0, 40], [0, 34], [37.5, 34]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
