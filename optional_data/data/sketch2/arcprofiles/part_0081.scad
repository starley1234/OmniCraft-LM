$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 23 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 36;               // bar height at the ends, Y
arc_r = 287.94;           // radius of the crown arc
arc_angle = 20;           // crown arc angle, degrees
crown_rise = 4.37;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[100, 36], [95.044, 36.829], [90.074, 37.572], [85.091, 38.228], [80.098, 38.797], [75.096, 39.278], [70.086, 39.673], [65.07, 39.979], [60.049, 40.199], [55.025, 40.33], [50, 40.374], [44.975, 40.33], [39.951, 40.199], [34.93, 39.979], [29.914, 39.673], [24.904, 39.278], [19.902, 38.797], [14.909, 38.228], [9.926, 37.572], [4.956, 36.829], [0, 36], [0, 0], [100, 0]];  // primary outline, 23 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
