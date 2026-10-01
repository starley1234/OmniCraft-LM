$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 36;               // bar height at the ends, Y
arc_r = 395.19;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.85;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 10;             // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[110, 36], [103.162, 36.9], [96.309, 37.681], [89.443, 38.342], [82.567, 38.883], [75.683, 39.304], [68.792, 39.605], [61.897, 39.786], [55, 39.846], [48.103, 39.786], [41.208, 39.605], [34.317, 39.304], [27.433, 38.883], [20.557, 38.342], [13.691, 37.681], [6.838, 36.9], [0, 36], [0, 0], [110, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
