$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: doublev, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
groove_off = 13;          // offset of each groove from the centreline

centre_x = rail_w / 2;  // rail centreline
groove_a = centre_x - groove_off;  // axis of the first groove
groove_b = centre_x + groove_off;  // axis of the second groove

profile = [[0, 0], [52, 0], [52, 12], [43, 12], [39, 2], [35, 12], [17, 12], [13, 2], [9, 12], [0, 12]];  // primary outline, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
