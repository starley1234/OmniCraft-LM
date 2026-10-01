$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: doublev, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 60;             // rail length, Z (the extrusion height)
groove_off = 13;          // offset of each groove from the centreline
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

centre_x = rail_w / 2;  // rail centreline
groove_a = centre_x - groove_off;  // axis of the first groove
groove_b = centre_x + groove_off;  // axis of the second groove

profile = [[0, 0], [52, 0], [52, 10], [43, 10], [39, 2], [35, 10], [17, 10], [13, 2], [9, 10], [0, 10]];  // primary outline, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
