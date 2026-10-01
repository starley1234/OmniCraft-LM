$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 36;               // bar height at the ends, Y
arc_r = 359.26;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.5;         // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[99.999, 36], [93.783, 36.818], [87.553, 37.528], [81.312, 38.129], [75.061, 38.621], [68.802, 39.004], [62.538, 39.277], [56.27, 39.441], [50, 39.496], [43.73, 39.441], [37.462, 39.277], [31.198, 39.004], [24.939, 38.621], [18.688, 38.129], [12.447, 37.528], [6.217, 36.818], [0.001, 36], [0, 0], [100, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
