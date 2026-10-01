$fn = 32;

// ----------------------------------------------------------------------
// Structural section: tee 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sec_w = 40;               // tee width, X
sec_h = 50;               // tee height, Y
flange_t = 8;             // top flange thickness
web_t = 5;                // web thickness
plate_t = 60;             // cut length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[17.5, 0], [22.5, 0], [22.5, 42], [40, 42], [40, 50], [0, 50], [0, 42], [17.5, 42]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
