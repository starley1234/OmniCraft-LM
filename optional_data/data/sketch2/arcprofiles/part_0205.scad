$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 395.19;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.85;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[110, 30], [103.162, 30.9], [96.309, 31.681], [89.443, 32.342], [82.567, 32.883], [75.683, 33.304], [68.792, 33.605], [61.897, 33.786], [55, 33.846], [48.103, 33.786], [41.208, 33.605], [34.317, 33.304], [27.433, 32.883], [20.557, 32.342], [13.691, 31.681], [6.838, 30.9], [0, 30], [0, 0], [110, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
