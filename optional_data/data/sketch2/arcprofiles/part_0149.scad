$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: notch, 45 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 46;               // bar width, Y
notch_depth = 10;         // depth of the arc notch at mid-span
arc_r = 156.25;           // radius of the notch arc
arc_angle = 41.22;        // notch arc angle, degrees
arc_step = 1;             // sampling step of the notch arc, degrees
plate_t = 5;              // plate thickness, Z
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [110, 0], [110, 46], [107.487, 45.079], [104.959, 44.202], [102.415, 43.368], [99.858, 42.578], [97.288, 41.831], [94.706, 41.129], [92.111, 40.471], [89.506, 39.858], [86.891, 39.289], [84.266, 38.765], [81.633, 38.287], [78.992, 37.853], [76.344, 37.465], [73.69, 37.122], [71.03, 36.824], [68.366, 36.573], [65.697, 36.367], [63.026, 36.206], [60.352, 36.092], [57.676, 36.023], [55, 36], [52.324, 36.023], [49.648, 36.092], [46.974, 36.206], [44.303, 36.367], [41.634, 36.573], [38.97, 36.824], [36.31, 37.122], [33.656, 37.465], [31.008, 37.853], [28.367, 38.287], [25.734, 38.765], [23.109, 39.289], [20.494, 39.858], [17.889, 40.471], [15.294, 41.129], [12.712, 41.831], [10.142, 42.578], [7.585, 43.368], [5.041, 44.202], [2.513, 45.079], [0, 46]];  // primary outline, 45 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
