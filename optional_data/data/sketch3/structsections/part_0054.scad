$fn = 32;

// ----------------------------------------------------------------------
// Structural section: ibeam 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // section width, X
sec_h = 60;               // section height, Y
flange_t = 5;             // flange thickness
web_t = 5;                // web thickness
plate_t = 40;             // cut length, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 5], [22.5, 5], [22.5, 55], [40, 55], [40, 60], [0, 60], [0, 55], [17.5, 55], [17.5, 5], [0, 5]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
