$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 431.12;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 4.2;         // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 10;             // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[120, 30], [112.54, 30.982], [105.064, 31.834], [97.575, 32.555], [90.073, 33.146], [82.563, 33.605], [75.046, 33.933], [67.524, 34.13], [60, 34.196], [52.476, 34.13], [44.954, 33.933], [37.437, 33.605], [29.927, 33.146], [22.425, 32.555], [14.936, 31.834], [7.46, 30.982], [0, 30], [0, 0], [120, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
