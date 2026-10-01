$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vway, 40 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 40;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 10;            // half width of the V at the base face
plate_t = 50;             // rail length, Z (the extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 10], [30, 10], [20, 2], [10, 10], [0, 10]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
