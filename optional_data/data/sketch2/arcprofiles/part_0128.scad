$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 359.26;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.5;         // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[99.999, 40], [93.783, 40.818], [87.553, 41.528], [81.312, 42.129], [75.061, 42.621], [68.802, 43.004], [62.538, 43.277], [56.27, 43.441], [50, 43.496], [43.73, 43.441], [37.462, 43.277], [31.198, 43.004], [24.939, 42.621], [18.688, 42.129], [12.447, 41.528], [6.217, 40.818], [0.001, 40], [0, 0], [100, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
