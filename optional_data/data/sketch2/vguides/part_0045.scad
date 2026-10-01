$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 46 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 46;              // rail width, X
base_t = 8;               // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 12;            // half width of the V at the base face
plate_t = 40;             // rail length, Z (the extrusion height)
top_half_w = 7.8;         // half width at the dovetail top

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [46, 0], [46, 8], [35, 8], [30.8, 16], [15.2, 16], [11, 8], [0, 8]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
