$fn = 32;

// ----------------------------------------------------------------------
// V guide rail: dovetail, 46 mm wide
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_w = 46;              // rail width, X
base_t = 12;              // base plate thickness
v_depth = 8;              // V feature depth / height
v_half_w = 12;            // half width of the V at the base face
plate_t = 50;             // rail length, Z (the extrusion height)
top_half_w = 8.4;         // half width at the dovetail top
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

dovetail_base = 2 * v_half_w;  // dovetail width at the base
dovetail_top = 2 * top_half_w;  // dovetail width at the top

profile = [[0, 0], [46, 0], [46, 12], [35, 12], [31.4, 20], [14.6, 20], [11, 12], [0, 12]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
