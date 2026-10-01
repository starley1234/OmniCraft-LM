$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 60 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // channel width, X
sec_h = 40;               // channel height, Y
flange_t = 5;             // flange thickness
web_t = 4;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 5], [4, 5], [4, 35], [60, 35], [60, 40], [0, 40]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
