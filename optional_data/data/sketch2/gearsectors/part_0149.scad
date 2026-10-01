$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[49.896, 0], [51.324, 2.973], [52.61, 6.01], [61.321, 6.513], [63.371, 13.57], [56.286, 18.662], [56.828, 21.916], [57.215, 25.191], [65.439, 28.105], [65.439, 35.453], [57.215, 38.367], [56.828, 41.642], [56.286, 44.896], [63.371, 49.988], [61.321, 57.045], [52.61, 57.548], [51.324, 60.585], [49.896, 63.558], [0, 38.135], [0.316, 37.473], [0.596, 36.796], [0.841, 36.105], [1.049, 35.402], [1.22, 34.69], [1.354, 33.969], [1.449, 33.242], [1.507, 32.512], [1.526, 31.779], [1.507, 31.046], [1.449, 30.316], [1.354, 29.589], [1.22, 28.868], [1.049, 28.156], [0.841, 27.453], [0.596, 26.762], [0.316, 26.085], [0, 25.423]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
