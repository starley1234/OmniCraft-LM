$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 30;               // bar height at the ends, Y
arc_r = 323.34;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.15;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 5;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[90, 30], [84.405, 30.737], [78.798, 31.376], [73.181, 31.917], [67.555, 32.359], [61.922, 32.704], [56.284, 32.95], [50.643, 33.098], [45, 33.147], [39.357, 33.098], [33.716, 32.95], [28.078, 32.704], [22.445, 32.359], [16.819, 31.917], [11.202, 31.376], [5.595, 30.737], [0, 30], [0, 0], [90, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
