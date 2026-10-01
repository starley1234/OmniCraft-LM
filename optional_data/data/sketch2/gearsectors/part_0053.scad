$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[57.158, 0], [59.157, 3.681], [60.96, 7.461], [67.23, 9.539], [69.98, 18], [66.128, 23.367], [66.891, 27.485], [67.438, 31.638], [72.76, 35.551], [72.76, 44.449], [67.438, 48.362], [66.891, 52.515], [66.128, 56.633], [69.98, 62], [67.23, 70.461], [60.96, 72.539], [59.157, 76.319], [57.158, 80], [0, 47], [0.35, 46.356], [0.666, 45.694], [0.946, 45.017], [1.191, 44.326], [1.399, 43.623], [1.57, 42.911], [1.704, 42.19], [1.799, 41.463], [1.857, 40.733], [1.876, 40], [1.857, 39.267], [1.799, 38.537], [1.704, 37.81], [1.57, 37.089], [1.399, 36.377], [1.191, 35.674], [0.946, 34.983], [0.666, 34.306], [0.35, 33.644], [0, 33]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
