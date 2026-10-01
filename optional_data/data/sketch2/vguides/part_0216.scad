$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vway, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 12;            // half width of the V at the base face
plate_t = 60;             // rail length, Z (the extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [60, 0], [60, 10], [42, 10], [30, 2], [18, 10], [0, 10]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
