$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 431.12;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 4.2;         // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[120, 40], [112.54, 40.982], [105.064, 41.834], [97.575, 42.555], [90.073, 43.146], [82.563, 43.605], [75.046, 43.933], [67.524, 44.13], [60, 44.196], [52.476, 44.13], [44.954, 43.933], [37.437, 43.605], [29.927, 43.146], [22.425, 42.555], [14.936, 41.834], [7.46, 40.982], [0, 40], [0, 0], [120, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
