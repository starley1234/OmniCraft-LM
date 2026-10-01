$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 23 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 259.14;           // radius of the crown arc
arc_angle = 20;           // crown arc angle, degrees
crown_rise = 3.94;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[89.999, 40], [85.538, 40.747], [81.065, 41.415], [76.581, 42.005], [72.088, 42.517], [67.586, 42.951], [63.077, 43.306], [58.562, 43.582], [54.044, 43.779], [49.523, 43.898], [45, 43.937], [40.477, 43.898], [35.956, 43.779], [31.438, 43.582], [26.923, 43.306], [22.414, 42.951], [17.912, 42.517], [13.419, 42.005], [8.935, 41.415], [4.462, 40.747], [0.001, 40], [0, 0], [90, 0]];  // primary outline, 23 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
