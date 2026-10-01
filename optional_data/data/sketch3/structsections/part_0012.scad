$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 80 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // channel width, X
sec_h = 60;               // channel height, Y
flange_t = 5;             // flange thickness
web_t = 4;                // web thickness
plate_t = 50;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 5], [4, 5], [4, 55], [80, 55], [80, 60], [0, 60]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
