$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: vrib, 46 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 46;              // rail width, X
base_t = 8;               // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)

profile = [[0, 0], [46, 0], [46, 8], [31, 8], [23, 16], [15, 8], [0, 8]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
