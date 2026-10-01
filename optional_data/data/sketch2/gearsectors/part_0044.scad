$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[31.177, 0], [32.294, 2.042], [33.314, 4.133], [34.235, 6.27], [41.284, 8.16], [43.261, 16.723], [37.754, 21.512], [37.862, 23.837], [37.862, 26.163], [37.754, 28.488], [43.261, 33.277], [41.284, 41.84], [34.235, 43.73], [33.314, 45.867], [32.294, 47.958], [31.177, 50], [0, 32], [0.35, 31.356], [0.666, 30.694], [0.946, 30.017], [1.191, 29.326], [1.399, 28.623], [1.57, 27.911], [1.704, 27.19], [1.799, 26.463], [1.857, 25.733], [1.876, 25], [1.857, 24.267], [1.799, 23.537], [1.704, 22.81], [1.57, 22.089], [1.399, 21.377], [1.191, 20.674], [0.946, 19.983], [0.666, 19.306], [0.35, 18.644], [0, 18]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
