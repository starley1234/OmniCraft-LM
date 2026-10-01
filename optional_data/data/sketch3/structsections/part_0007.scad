$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 6;             // flange thickness
web_t = 6;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 6], [23, 6], [23, 54], [40, 54], [40, 60], [0, 60], [0, 54], [17, 54], [17, 6], [0, 6]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
