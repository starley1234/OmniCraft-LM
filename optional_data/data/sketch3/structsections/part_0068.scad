$fn = 32;

// ----------------------------------------------------------------------
// Structural section: angle 80 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // leg width, X
sec_h = 60;               // leg height, Y
flange_t = 8;             // leg thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 8], [8, 8], [8, 60], [0, 60]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
