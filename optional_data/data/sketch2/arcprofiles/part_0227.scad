$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 27 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 216.44;           // radius of the crown arc
arc_angle = 24;           // crown arc angle, degrees
crown_rise = 4.73;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[90, 40], [86.299, 40.753], [82.584, 41.442], [78.859, 42.065], [75.123, 42.624], [71.377, 43.117], [67.624, 43.544], [63.864, 43.906], [60.098, 44.203], [56.328, 44.433], [52.554, 44.598], [48.777, 44.697], [45, 44.73], [41.223, 44.697], [37.446, 44.598], [33.672, 44.433], [29.902, 44.203], [26.136, 43.906], [22.376, 43.544], [18.623, 43.117], [14.877, 42.624], [11.141, 42.065], [7.416, 41.442], [3.701, 40.753], [0, 40], [0, 0], [90, 0]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
