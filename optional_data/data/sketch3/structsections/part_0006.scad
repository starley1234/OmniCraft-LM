$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 50 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // channel width, X
sec_h = 80;               // channel height, Y
flange_t = 8;             // flange thickness
web_t = 4;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 8], [4, 8], [4, 72], [50, 72], [50, 80], [0, 80]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
