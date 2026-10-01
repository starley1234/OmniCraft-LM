$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 40 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 40;              // rail width, X
base_t = 8;               // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 7;             // half width of the V at the base face
plate_t = 60;             // rail length, Z (the extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 8], [27, 8], [20, 16], [13, 8], [0, 8]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
