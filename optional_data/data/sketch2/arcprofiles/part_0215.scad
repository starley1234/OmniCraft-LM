$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 23 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 316.73;           // radius of the crown arc
arc_angle = 20;           // crown arc angle, degrees
crown_rise = 4.81;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[110, 30], [104.547, 30.913], [99.08, 31.73], [93.6, 32.451], [88.107, 33.077], [82.605, 33.607], [77.094, 34.04], [71.576, 34.378], [66.054, 34.619], [60.528, 34.764], [55, 34.812], [49.472, 34.764], [43.946, 34.619], [38.424, 34.378], [32.906, 34.04], [27.395, 33.607], [21.893, 33.077], [16.4, 32.451], [10.92, 31.73], [5.453, 30.913], [0, 30], [0, 0], [110, 0]];  // primary outline, 23 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
