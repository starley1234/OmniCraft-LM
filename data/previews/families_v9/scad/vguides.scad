$fn = 32;
// target_bbox: 60, 18, 80
// ----------------------------------------------------------------------
// V guide rail: dovetail, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 8;               // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 10;            // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
top_half_w = 6.8;         // half width at the dovetail top

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [60, 0], [60, 8], [40, 8], [36.8, 18], [23.2, 18], [20, 8], [0, 8]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
