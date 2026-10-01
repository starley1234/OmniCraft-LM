$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vway, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 10;            // half width of the V at the base face
plate_t = 40;             // rail length, Z (the extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [60, 0], [60, 12], [40, 12], [30, 6], [20, 12], [0, 12]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
