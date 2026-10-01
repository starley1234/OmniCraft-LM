$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vway, 46 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 46;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[0, 0], [46, 0], [46, 12], [31, 12], [23, 4], [15, 12], [0, 12]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
