$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 80 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // channel width, X
sec_h = 40;               // channel height, Y
flange_t = 5;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 5], [5, 5], [5, 35], [80, 35], [80, 40], [0, 40]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
