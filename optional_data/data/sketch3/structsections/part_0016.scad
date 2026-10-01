$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 80 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // channel width, X
sec_h = 80;               // channel height, Y
flange_t = 6;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 6], [5, 6], [5, 74], [80, 74], [80, 80], [0, 80]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
