$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // channel width, X
sec_h = 40;               // channel height, Y
flange_t = 8;             // flange thickness
web_t = 4;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 8], [4, 8], [4, 32], [80, 32], [80, 40], [0, 40]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
