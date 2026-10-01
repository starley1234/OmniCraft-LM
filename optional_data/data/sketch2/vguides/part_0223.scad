$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 7;             // half width of the V at the base face
plate_t = 50;             // rail length, Z (the extrusion height)
top_half_w = 3.6;         // half width at the dovetail top

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [52, 0], [52, 10], [33, 10], [29.6, 18], [22.4, 18], [19, 10], [0, 10]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
