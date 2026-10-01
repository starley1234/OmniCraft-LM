$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 23 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 316.73;           // radius of the crown arc
arc_angle = 20;           // crown arc angle, degrees
crown_rise = 4.81;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[110, 40], [104.547, 40.913], [99.08, 41.73], [93.6, 42.451], [88.107, 43.077], [82.605, 43.607], [77.094, 44.04], [71.576, 44.378], [66.054, 44.619], [60.528, 44.764], [55, 44.812], [49.472, 44.764], [43.946, 44.619], [38.424, 44.378], [32.906, 44.04], [27.395, 43.607], [21.893, 43.077], [16.4, 42.451], [10.92, 41.73], [5.453, 40.913], [0, 40], [0, 0], [110, 0]];  // primary outline, 23 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
