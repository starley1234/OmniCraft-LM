$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 40 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 40;              // rail width, X
base_t = 10;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 60;             // rail length, Z (the extrusion height)
top_half_w = 4.9;         // half width at the dovetail top

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [40, 0], [40, 10], [28, 10], [24.9, 18], [15.1, 18], [12, 10], [0, 10]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
