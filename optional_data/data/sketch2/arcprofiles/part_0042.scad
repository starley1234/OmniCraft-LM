$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: notch, 40 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 36;               // bar width, Y
notch_depth = 8;          // depth of the arc notch at mid-span
arc_r = 160.25;           // radius of the notch arc
arc_angle = 36.36;        // notch arc angle, degrees
arc_step = 1;             // sampling step of the notch arc, degrees
plate_t = 10;             // plate thickness, Z
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 0], [100, 0], [100, 36], [97.381, 35.165], [94.749, 34.375], [92.103, 33.63], [89.445, 32.93], [86.775, 32.277], [84.095, 31.669], [81.404, 31.107], [78.704, 30.592], [75.996, 30.123], [73.28, 29.7], [70.558, 29.324], [67.829, 28.995], [65.095, 28.713], [62.356, 28.477], [59.614, 28.289], [56.869, 28.147], [54.122, 28.053], [51.374, 28.006], [48.626, 28.006], [45.878, 28.053], [43.131, 28.147], [40.386, 28.289], [37.644, 28.477], [34.905, 28.713], [32.171, 28.995], [29.442, 29.324], [26.72, 29.7], [24.004, 30.123], [21.296, 30.592], [18.596, 31.107], [15.905, 31.669], [13.225, 32.277], [10.555, 32.93], [7.897, 33.63], [5.251, 34.375], [2.619, 35.165], [0, 36]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
