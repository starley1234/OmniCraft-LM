$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 40;               // bar height at the ends, Y
arc_r = 323.34;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.15;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 5;              // plate thickness, Z
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[90, 40], [84.405, 40.737], [78.798, 41.376], [73.181, 41.917], [67.555, 42.359], [61.922, 42.704], [56.284, 42.95], [50.643, 43.098], [45, 43.147], [39.357, 43.098], [33.716, 42.95], [28.078, 42.704], [22.445, 42.359], [16.819, 41.917], [11.202, 41.376], [5.595, 40.737], [0, 40], [0, 0], [90, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
