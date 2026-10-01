$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vway, 46 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 46;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 7;             // half width of the V at the base face
plate_t = 50;             // rail length, Z (the extrusion height)

profile = [[0, 0], [46, 0], [46, 10], [30, 10], [23, 2], [16, 10], [0, 10]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
