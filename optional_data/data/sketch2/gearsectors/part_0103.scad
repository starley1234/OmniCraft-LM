$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[48.498, 0], [50.061, 2.858], [51.489, 5.786], [52.779, 8.778], [59.405, 12.447], [62.052, 23.914], [57.705, 30.117], [57.857, 33.371], [57.857, 36.629], [57.705, 39.883], [62.052, 46.086], [59.405, 57.553], [52.779, 61.222], [51.489, 64.214], [50.061, 67.142], [48.498, 70], [0, 42], [0.35, 41.356], [0.666, 40.694], [0.946, 40.017], [1.191, 39.326], [1.399, 38.623], [1.57, 37.911], [1.704, 37.19], [1.799, 36.463], [1.857, 35.733], [1.876, 35], [1.857, 34.267], [1.799, 33.537], [1.704, 32.81], [1.57, 32.089], [1.399, 31.377], [1.191, 30.674], [0.946, 29.983], [0.666, 29.306], [0.35, 28.644], [0, 28]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
