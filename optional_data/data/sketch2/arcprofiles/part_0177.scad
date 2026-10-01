$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 23 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 287.94;           // radius of the crown arc
arc_angle = 20;           // crown arc angle, degrees
crown_rise = 4.37;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[100, 30], [95.044, 30.829], [90.074, 31.572], [85.091, 32.228], [80.098, 32.797], [75.096, 33.278], [70.086, 33.673], [65.07, 33.979], [60.049, 34.199], [55.025, 34.33], [50, 34.374], [44.975, 34.33], [39.951, 34.199], [34.93, 33.979], [29.914, 33.673], [24.904, 33.278], [19.902, 32.797], [14.909, 32.228], [9.926, 31.572], [4.956, 30.829], [0, 30], [0, 0], [100, 0]];  // primary outline, 23 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
