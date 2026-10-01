$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // channel width, X
sec_h = 50;               // channel height, Y
flange_t = 8;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 8], [5, 8], [5, 42], [50, 42], [50, 50], [0, 50]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
