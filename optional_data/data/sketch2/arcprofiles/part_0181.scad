$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 27 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 288.58;           // radius of the crown arc
arc_angle = 24;           // crown arc angle, degrees
crown_rise = 6.31;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[119.999, 30], [115.064, 31.004], [110.111, 31.922], [105.144, 32.753], [100.163, 33.498], [95.169, 34.155], [90.165, 34.725], [85.151, 35.208], [80.13, 35.603], [75.103, 35.911], [70.071, 36.13], [65.036, 36.262], [60, 36.306], [54.964, 36.262], [49.929, 36.13], [44.897, 35.911], [39.87, 35.603], [34.849, 35.208], [29.835, 34.725], [24.831, 34.155], [19.837, 33.498], [14.856, 32.753], [9.889, 31.922], [4.936, 31.004], [0.001, 30], [0, 0], [120, 0]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
