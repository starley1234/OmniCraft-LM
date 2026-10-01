$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 23 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 259.14;           // radius of the crown arc
arc_angle = 20;           // crown arc angle, degrees
crown_rise = 3.94;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[89.999, 30], [85.538, 30.747], [81.065, 31.415], [76.581, 32.005], [72.088, 32.517], [67.586, 32.951], [63.077, 33.306], [58.562, 33.582], [54.044, 33.779], [49.523, 33.898], [45, 33.937], [40.477, 33.898], [35.956, 33.779], [31.438, 33.582], [26.923, 33.306], [22.414, 32.951], [17.912, 32.517], [13.419, 32.005], [8.935, 31.415], [4.462, 30.747], [0.001, 30], [0, 0], [90, 0]];  // primary outline, 23 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
