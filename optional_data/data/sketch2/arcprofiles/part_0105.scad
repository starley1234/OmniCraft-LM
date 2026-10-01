$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 27 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 288.58;           // radius of the crown arc
arc_angle = 24;           // crown arc angle, degrees
crown_rise = 6.31;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 5;              // plate thickness, Z
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[119.999, 40], [115.064, 41.004], [110.111, 41.922], [105.144, 42.753], [100.163, 43.498], [95.169, 44.155], [90.165, 44.725], [85.151, 45.208], [80.13, 45.603], [75.103, 45.911], [70.071, 46.13], [65.036, 46.262], [60, 46.306], [54.964, 46.262], [49.929, 46.13], [44.897, 45.911], [39.87, 45.603], [34.849, 45.208], [29.835, 44.725], [24.831, 44.155], [19.837, 43.498], [14.856, 42.753], [9.889, 41.922], [4.936, 41.004], [0.001, 40], [0, 0], [120, 0]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
