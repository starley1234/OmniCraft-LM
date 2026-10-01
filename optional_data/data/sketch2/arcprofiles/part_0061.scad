$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: notch, 45 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 36;               // bar width, Y
notch_depth = 10;         // depth of the arc notch at mid-span
arc_r = 156.25;           // radius of the notch arc
arc_angle = 41.22;        // notch arc angle, degrees
arc_step = 1;             // sampling step of the notch arc, degrees
plate_t = 6;              // plate thickness, Z
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [110, 0], [110, 36], [107.487, 35.079], [104.959, 34.202], [102.415, 33.368], [99.858, 32.578], [97.288, 31.831], [94.706, 31.129], [92.111, 30.471], [89.506, 29.858], [86.891, 29.289], [84.266, 28.765], [81.633, 28.287], [78.992, 27.853], [76.344, 27.465], [73.69, 27.122], [71.03, 26.824], [68.366, 26.573], [65.697, 26.367], [63.026, 26.206], [60.352, 26.092], [57.676, 26.023], [55, 26], [52.324, 26.023], [49.648, 26.092], [46.974, 26.206], [44.303, 26.367], [41.634, 26.573], [38.97, 26.824], [36.31, 27.122], [33.656, 27.465], [31.008, 27.853], [28.367, 28.287], [25.734, 28.765], [23.109, 29.289], [20.494, 29.858], [17.889, 30.471], [15.294, 31.129], [12.712, 31.831], [10.142, 32.578], [7.585, 33.368], [5.041, 34.202], [2.513, 35.079], [0, 36]];  // primary outline, 45 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
