$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: doublev, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 10;            // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
groove_off = 15;          // offset of each groove from the centreline

centre_x = rail_w / 2;  // rail centreline
groove_a = centre_x - groove_off;  // axis of the first groove
groove_b = centre_x + groove_off;  // axis of the second groove

profile = [[0, 0], [60, 0], [60, 10], [50, 10], [45, 4], [40, 10], [20, 10], [15, 4], [10, 10], [0, 10]];  // primary outline, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
