$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 52 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 52;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 6;              // V feature depth / height
v_half_w = 8;             // half width of the V at the base face
plate_t = 80;             // rail length, Z (the extrusion height)
top_half_w = 5.5;         // half width at the dovetail top
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [52, 0], [52, 12], [34, 12], [31.5, 18], [20.5, 18], [18, 12], [0, 12]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
