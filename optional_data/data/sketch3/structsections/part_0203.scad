$fn = 32;

// ----------------------------------------------------------------------
// Structural section: angle 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // leg width, X
sec_h = 50;               // leg height, Y
flange_t = 8;             // leg thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 8], [8, 8], [8, 50], [0, 50]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
