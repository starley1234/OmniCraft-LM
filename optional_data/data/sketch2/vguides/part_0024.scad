$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 40 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 40;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 30;             // rail length, Z (the extrusion height)

profile = [[0, 0], [40, 0], [40, 10], [28, 10], [20, 18], [12, 10], [0, 10]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
