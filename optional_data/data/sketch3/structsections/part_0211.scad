$fn = 32;

// ----------------------------------------------------------------------
// Structural section: angle 50 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // leg width, X
sec_h = 60;               // leg height, Y
flange_t = 5;             // leg thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 5], [5, 5], [5, 60], [0, 60]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
