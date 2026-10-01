$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 60 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 60;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 60;             // rail length, Z (the extrusion height)
top_half_w = 4.6;         // half width at the dovetail top

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [60, 0], [60, 12], [38, 12], [34.6, 18], [25.4, 18], [22, 12], [0, 12]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
