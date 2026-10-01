$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[31.177, 0], [32.186, 1.835], [33.117, 3.711], [41.285, 2.384], [42.895, 6.644], [35.891, 11.05], [36.433, 13.073], [36.89, 15.117], [45.138, 15.777], [45.685, 20.298], [37.832, 22.906], [37.876, 25], [37.832, 27.094], [45.685, 29.702], [45.138, 34.223], [36.89, 34.883], [36.433, 36.927], [35.891, 38.95], [42.895, 43.356], [41.285, 47.616], [33.117, 46.289], [32.186, 48.165], [31.177, 50], [0, 32], [0.35, 31.356], [0.666, 30.694], [0.946, 30.017], [1.191, 29.326], [1.399, 28.623], [1.57, 27.911], [1.704, 27.19], [1.799, 26.463], [1.857, 25.733], [1.876, 25], [1.857, 24.267], [1.799, 23.537], [1.704, 22.81], [1.57, 22.089], [1.399, 21.377], [1.191, 20.674], [0.946, 19.983], [0.666, 19.306], [0.35, 18.644], [0, 18]];  // primary outline, 44 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
