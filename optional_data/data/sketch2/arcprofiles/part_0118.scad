$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: crown, 19 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 36;               // bar height at the ends, Y
arc_r = 323.34;           // radius of the crown arc
arc_angle = 16;           // crown arc angle, degrees
crown_rise = 3.15;        // rise of the crown over the ends
arc_step = 1;             // sampling step of the crown arc, degrees
plate_t = 6;              // plate thickness, Z

bbox_y = bar_w + crown_rise;  // full height with the crown

profile = [[90, 36], [84.405, 36.737], [78.798, 37.376], [73.181, 37.917], [67.555, 38.359], [61.922, 38.704], [56.284, 38.95], [50.643, 39.098], [45, 39.147], [39.357, 39.098], [33.716, 38.95], [28.078, 38.704], [22.445, 38.359], [16.819, 37.917], [11.202, 37.376], [5.595, 36.737], [0, 36], [0, 0], [90, 0]];  // primary outline, 19 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
