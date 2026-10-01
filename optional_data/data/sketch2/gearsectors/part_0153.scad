$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[58.807, 0], [60.265, 3.017], [61.596, 6.092], [62.796, 9.22], [70.297, 12.975], [72.761, 24.871], [67.368, 31.296], [67.508, 34.644], [67.508, 37.994], [67.368, 41.342], [72.761, 47.767], [70.297, 59.663], [62.796, 63.418], [61.596, 66.546], [60.265, 69.621], [58.807, 72.638], [0, 42.675], [0.316, 42.013], [0.596, 41.336], [0.841, 40.645], [1.049, 39.942], [1.22, 39.23], [1.354, 38.509], [1.449, 37.782], [1.507, 37.052], [1.526, 36.319], [1.507, 35.586], [1.449, 34.856], [1.354, 34.129], [1.22, 33.408], [1.049, 32.696], [0.841, 31.993], [0.596, 31.302], [0.316, 30.625], [0, 29.963]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
