$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 60 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 60;               // channel width, X
sec_h = 50;               // channel height, Y
flange_t = 6;             // flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [60, 0], [60, 6], [6, 6], [6, 44], [60, 44], [60, 50], [0, 50]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
