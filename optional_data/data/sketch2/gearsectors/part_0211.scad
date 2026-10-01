$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[52.281, 0], [53.156, 2.412], [53.942, 4.854], [59.475, 6.054], [60.674, 11.418], [56.179, 14.86], [56.507, 17.405], [56.742, 19.959], [61.88, 22.338], [61.88, 27.834], [56.742, 30.213], [56.507, 32.767], [56.179, 35.312], [60.674, 38.754], [59.475, 44.118], [53.942, 45.318], [53.156, 47.76], [52.281, 50.172], [0, 30.103], [0.245, 29.412], [0.453, 28.709], [0.624, 27.997], [0.758, 27.276], [0.853, 26.549], [0.911, 25.819], [0.93, 25.086], [0.911, 24.353], [0.853, 23.623], [0.758, 22.896], [0.624, 22.175], [0.453, 21.463], [0.245, 20.76], [0, 20.069]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
