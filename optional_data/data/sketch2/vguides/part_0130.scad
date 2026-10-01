$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: doublev, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 8;               // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 10;            // half width of the V at the base face
plate_t = 50;             // rail length, Z (the extrusion height)
groove_off = 13;          // offset of each groove from the centreline
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

centre_x = rail_w / 2;  // rail centreline
groove_a = centre_x - groove_off;  // axis of the first groove
groove_b = centre_x + groove_off;  // axis of the second groove

profile = [[0, 0], [52, 0], [52, 8], [44, 8], [39, 2], [34, 8], [18, 8], [13, 2], [8, 8], [0, 8]];  // primary outline, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
