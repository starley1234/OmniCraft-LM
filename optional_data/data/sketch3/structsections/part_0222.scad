$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // channel width, X
sec_h = 40;               // channel height, Y
flange_t = 5;             // flange thickness
web_t = 6;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)

profile = [[0, 0], [40, 0], [40, 5], [6, 5], [6, 35], [40, 35], [40, 40], [0, 40]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
