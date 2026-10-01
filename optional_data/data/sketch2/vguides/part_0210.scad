$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 30;             // rail length, Z (the extrusion height)

profile = [[0, 0], [60, 0], [60, 12], [38, 12], [30, 22], [22, 12], [0, 12]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
