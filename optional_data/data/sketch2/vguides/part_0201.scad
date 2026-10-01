$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 10;            // half width of the V at the base face
plate_t = 60;             // rail length, Z (the extrusion height)

profile = [[0, 0], [52, 0], [52, 10], [36, 10], [26, 20], [16, 10], [0, 10]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
