$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 50 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // channel width, X
sec_h = 40;               // channel height, Y
flange_t = 6;             // flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 6], [4, 6], [4, 34], [50, 34], [50, 40], [0, 40]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
