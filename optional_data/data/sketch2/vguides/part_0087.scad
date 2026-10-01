$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 40 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 40;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 10;             // V feature depth / height
v_half_w = 7;             // half width of the V at the base face
plate_t = 30;             // rail length, Z (the extrusion height)
top_half_w = 4;           // half width at the dovetail top
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [40, 0], [40, 12], [27, 12], [24, 22], [16, 22], [13, 12], [0, 12]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
