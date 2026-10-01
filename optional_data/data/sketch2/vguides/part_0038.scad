$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: doublev, 46 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 46;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 40;             // rail length, Z (the extrusion height)
groove_off = 11.5;        // offset of each groove from the centreline

centre_x = rail_w / 2;  // rail centreline
groove_a = centre_x - groove_off;  // axis of the first groove
groove_b = centre_x + groove_off;  // axis of the second groove

profile = [[0, 0], [46, 0], [46, 10], [38.5, 10], [34.5, 4], [30.5, 10], [15.5, 10], [11.5, 4], [7.5, 10], [0, 10]];  // primary outline, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
