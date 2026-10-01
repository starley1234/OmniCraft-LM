$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 27 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 36;               // bar height at the ends, Y
arc_r = 288.58;           // radius of the crown arc
arc_angle = 24;           // crown arc angle, degrees
crown_rise = 6.31;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[119.999, 36], [115.064, 37.004], [110.111, 37.922], [105.144, 38.753], [100.163, 39.498], [95.169, 40.155], [90.165, 40.725], [85.151, 41.208], [80.13, 41.603], [75.103, 41.911], [70.071, 42.13], [65.036, 42.262], [60, 42.306], [54.964, 42.262], [49.929, 42.13], [44.897, 41.911], [39.87, 41.603], [34.849, 41.208], [29.835, 40.725], [24.831, 40.155], [19.837, 39.498], [14.856, 38.753], [9.889, 37.922], [4.936, 37.004], [0.001, 36], [0, 0], [120, 0]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
