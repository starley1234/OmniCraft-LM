$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: doublev, 40 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 40;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 50;             // rail length, Z (the extrusion height)
groove_off = 10;          // offset of each groove from the centreline

centre_x = rail_w / 2;  // rail centreline
groove_a = centre_x - groove_off;  // axis of the first groove
groove_b = centre_x + groove_off;  // axis of the second groove

profile = [[0, 0], [40, 0], [40, 12], [34, 12], [30, 4], [26, 12], [14, 12], [10, 4], [6, 12], [0, 12]];  // primary outline, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
