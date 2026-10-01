$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 80 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[37, 0], [43, 0], [43, 54], [80, 54], [80, 60], [0, 60], [0, 54], [37, 54]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
