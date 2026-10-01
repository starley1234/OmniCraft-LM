$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // tee width, X
sec_h = 60;               // tee height, Y
flange_t = 6;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 80;             // cut length, Z (extrusion height)

profile = [[17.5, 0], [22.5, 0], [22.5, 54], [40, 54], [40, 60], [0, 60], [0, 54], [17.5, 54]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
