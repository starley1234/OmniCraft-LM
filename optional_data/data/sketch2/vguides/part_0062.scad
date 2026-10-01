$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 46 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 46;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 7;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)

profile = [[0, 0], [46, 0], [46, 12], [30, 12], [23, 22], [16, 12], [0, 12]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
