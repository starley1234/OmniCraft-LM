$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 8;               // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 60;             // rail length, Z (the extrusion height)

profile = [[0, 0], [60, 0], [60, 8], [38, 8], [30, 14], [22, 8], [0, 8]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
