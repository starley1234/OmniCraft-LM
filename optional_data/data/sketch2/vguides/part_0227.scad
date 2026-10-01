$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 10;            // half width of the V at the base face
plate_t = 40;             // rail length, Z (the extrusion height)
top_half_w = 5.7;         // half width at the dovetail top

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [52, 0], [52, 10], [36, 10], [31.7, 20], [20.3, 20], [16, 10], [0, 10]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
