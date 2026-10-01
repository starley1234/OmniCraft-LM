$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 23 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 287.94;           // radius of the crown arc
arc_angle = 20;           // crown arc angle, degrees
crown_rise = 4.37;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[100, 40], [95.044, 40.829], [90.074, 41.572], [85.091, 42.228], [80.098, 42.797], [75.096, 43.278], [70.086, 43.673], [65.07, 43.979], [60.049, 44.199], [55.025, 44.33], [50, 44.374], [44.975, 44.33], [39.951, 44.199], [34.93, 43.979], [29.914, 43.673], [24.904, 43.278], [19.902, 42.797], [14.909, 42.228], [9.926, 41.572], [4.956, 40.829], [0, 40], [0, 0], [100, 0]];  // primary outline, 23 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
