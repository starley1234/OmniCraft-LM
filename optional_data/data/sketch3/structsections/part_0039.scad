$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 80 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 80;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)

profile = [[0, 0], [80, 0], [80, 6], [42.5, 6], [42.5, 54], [80, 54], [80, 60], [0, 60], [0, 54], [37.5, 54], [37.5, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
