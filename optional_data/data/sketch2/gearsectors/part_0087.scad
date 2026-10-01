$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[52.281, 0], [52.988, 1.927], [53.639, 3.874], [59.001, 4.331], [60.033, 8.323], [55.563, 11.322], [55.937, 13.34], [56.252, 15.368], [61.462, 16.719], [61.809, 20.828], [56.9, 23.034], [56.93, 25.086], [56.9, 27.138], [61.809, 29.344], [61.462, 33.453], [56.252, 34.804], [55.937, 36.832], [55.563, 38.85], [60.033, 41.849], [59.001, 45.841], [53.639, 46.298], [52.988, 48.245], [52.281, 50.172], [0, 30.103], [0.245, 29.412], [0.453, 28.709], [0.624, 27.997], [0.758, 27.276], [0.853, 26.549], [0.911, 25.819], [0.93, 25.086], [0.911, 24.353], [0.853, 23.623], [0.758, 22.896], [0.624, 22.175], [0.453, 21.463], [0.245, 20.76], [0, 20.069]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
