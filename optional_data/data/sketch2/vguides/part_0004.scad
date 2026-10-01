$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 40 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 40;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 7;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [40, 0], [40, 12], [27, 12], [20, 18], [13, 12], [0, 12]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
