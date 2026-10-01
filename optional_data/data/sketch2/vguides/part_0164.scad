$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
top_half_w = 4.6;         // half width at the dovetail top

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [52, 0], [52, 10], [34, 10], [30.6, 20], [21.4, 20], [18, 10], [0, 10]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
