$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 36;               // bar height at the ends, Y
arc_r = 431.12;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 4.2;         // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 8;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[120, 36], [112.54, 36.982], [105.064, 37.834], [97.575, 38.555], [90.073, 39.146], [82.563, 39.605], [75.046, 39.933], [67.524, 40.13], [60, 40.196], [52.476, 40.13], [44.954, 39.933], [37.437, 39.605], [29.927, 39.146], [22.425, 38.555], [14.936, 37.834], [7.46, 36.982], [0, 36], [0, 0], [120, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
