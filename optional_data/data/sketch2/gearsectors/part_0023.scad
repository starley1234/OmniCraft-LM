$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[60.294, 0], [61.454, 2.743], [62.512, 5.528], [63.465, 8.349], [70.655, 11.734], [72.605, 22.356], [67.085, 28.073], [67.196, 31.05], [67.196, 34.028], [67.085, 37.005], [72.605, 42.722], [70.655, 53.344], [63.465, 56.729], [62.512, 59.55], [61.454, 62.335], [60.294, 65.078], [0, 38.233], [0.28, 37.556], [0.525, 36.865], [0.733, 36.162], [0.904, 35.45], [1.038, 34.729], [1.133, 34.002], [1.191, 33.272], [1.21, 32.539], [1.191, 31.806], [1.133, 31.076], [1.038, 30.349], [0.904, 29.628], [0.733, 28.916], [0.525, 28.213], [0.28, 27.522], [0, 26.845]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
