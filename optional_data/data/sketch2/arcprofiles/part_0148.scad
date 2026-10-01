$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 395.19;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.85;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 5;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[110, 40], [103.162, 40.9], [96.309, 41.681], [89.443, 42.342], [82.567, 42.883], [75.683, 43.304], [68.792, 43.605], [61.897, 43.786], [55, 43.846], [48.103, 43.786], [41.208, 43.605], [34.317, 43.304], [27.433, 42.883], [20.557, 42.342], [13.691, 41.681], [6.838, 40.9], [0, 40], [0, 0], [110, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
