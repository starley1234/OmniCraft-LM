$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: doublev, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 7;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
groove_off = 15;          // offset of each groove from the centreline

centre_x = rail_w / 2;  // rail centreline
groove_a = centre_x - groove_off;  // axis of the first groove
groove_b = centre_x + groove_off;  // axis of the second groove

profile = [[0, 0], [60, 0], [60, 12], [48.5, 12], [45, 4], [41.5, 12], [18.5, 12], [15, 4], [11.5, 12], [0, 12]];  // primary outline, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
