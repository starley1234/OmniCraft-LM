$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 8;               // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 12;            // half width of the V at the base face
plate_t = 50;             // rail length, Z (the extrusion height)

profile = [[0, 0], [52, 0], [52, 8], [38, 8], [26, 14], [14, 8], [0, 8]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
