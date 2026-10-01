$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[52.281, 0], [53.428, 3.223], [54.417, 6.497], [61.2, 8.96], [62.521, 17.208], [56.846, 21.667], [56.93, 25.086], [56.846, 28.505], [62.521, 32.964], [61.2, 41.212], [54.417, 43.675], [53.428, 46.949], [52.281, 50.172], [0, 30.103], [0.245, 29.412], [0.453, 28.709], [0.624, 27.997], [0.758, 27.276], [0.853, 26.549], [0.911, 25.819], [0.93, 25.086], [0.911, 24.353], [0.853, 23.623], [0.758, 22.896], [0.624, 22.175], [0.453, 21.463], [0.245, 20.76], [0, 20.069]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
