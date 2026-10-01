$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 27 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 36;               // bar height at the ends, Y
arc_r = 216.44;           // radius of the crown arc
arc_angle = 24;           // crown arc angle, degrees
crown_rise = 4.73;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 10;             // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[90, 36], [86.299, 36.753], [82.584, 37.442], [78.859, 38.065], [75.123, 38.624], [71.377, 39.117], [67.624, 39.544], [63.864, 39.906], [60.098, 40.203], [56.328, 40.433], [52.554, 40.598], [48.777, 40.697], [45, 40.73], [41.223, 40.697], [37.446, 40.598], [33.672, 40.433], [29.902, 40.203], [26.136, 39.906], [22.376, 39.544], [18.623, 39.117], [14.877, 38.624], [11.141, 38.065], [7.416, 37.442], [3.701, 36.753], [0, 36], [0, 0], [90, 0]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
