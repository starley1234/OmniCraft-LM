$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[39.838, 0], [41.336, 2.761], [42.689, 5.596], [50.426, 5.989], [52.593, 12.659], [46.565, 17.525], [47.137, 20.614], [47.547, 23.728], [54.784, 26.493], [54.784, 33.507], [47.547, 36.272], [47.137, 39.386], [46.565, 42.475], [52.593, 47.341], [50.426, 54.011], [42.689, 54.404], [41.336, 57.239], [39.838, 60], [0, 37], [0.35, 36.356], [0.666, 35.694], [0.946, 35.017], [1.191, 34.326], [1.399, 33.623], [1.57, 32.911], [1.704, 32.19], [1.799, 31.463], [1.857, 30.733], [1.876, 30], [1.857, 29.267], [1.799, 28.537], [1.704, 27.81], [1.57, 27.089], [1.399, 26.377], [1.191, 25.674], [0.946, 24.983], [0.666, 24.306], [0.35, 23.644], [0, 23]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
