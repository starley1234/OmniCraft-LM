$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 359.26;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.5;         // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[99.999, 30], [93.783, 30.818], [87.553, 31.528], [81.312, 32.129], [75.061, 32.621], [68.802, 33.004], [62.538, 33.277], [56.27, 33.441], [50, 33.496], [43.73, 33.441], [37.462, 33.277], [31.198, 33.004], [24.939, 32.621], [18.688, 32.129], [12.447, 31.528], [6.217, 30.818], [0.001, 30], [0, 0], [100, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
