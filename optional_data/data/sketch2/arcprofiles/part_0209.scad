$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: notch, 45 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar width, Y
notch_depth = 10;         // depth of the arc notch at mid-span
arc_r = 156.25;           // radius of the notch arc
arc_angle = 41.22;        // notch arc angle, degrees
arc_step = 1;             // sampling step of the notch arc, degrees
plate_t = 10;             // plate thickness, Z
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 0], [110, 0], [110, 40], [107.487, 39.079], [104.959, 38.202], [102.415, 37.368], [99.858, 36.578], [97.288, 35.831], [94.706, 35.129], [92.111, 34.471], [89.506, 33.858], [86.891, 33.289], [84.266, 32.765], [81.633, 32.287], [78.992, 31.853], [76.344, 31.465], [73.69, 31.122], [71.03, 30.824], [68.366, 30.573], [65.697, 30.367], [63.026, 30.206], [60.352, 30.092], [57.676, 30.023], [55, 30], [52.324, 30.023], [49.648, 30.092], [46.974, 30.206], [44.303, 30.367], [41.634, 30.573], [38.97, 30.824], [36.31, 31.122], [33.656, 31.465], [31.008, 31.853], [28.367, 32.287], [25.734, 32.765], [23.109, 33.289], [20.494, 33.858], [17.889, 34.471], [15.294, 35.129], [12.712, 35.831], [10.142, 36.578], [7.585, 37.368], [5.041, 38.202], [2.513, 39.079], [0, 40]];  // primary outline, 45 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
