$fn = 32;

// ----------------------------------------------------------------------
// Structural section: channel 50 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 50;               // channel width, X
sec_h = 60;               // channel height, Y
flange_t = 6;             // flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[0, 0], [50, 0], [50, 6], [5, 6], [5, 54], [50, 54], [50, 60], [0, 60]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
