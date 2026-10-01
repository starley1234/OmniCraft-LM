$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[31.177, 0], [32.426, 2.3], [33.553, 4.663], [41.09, 4.573], [42.934, 10.247], [36.783, 14.604], [37.26, 17.178], [37.602, 19.774], [44.798, 22.017], [44.798, 27.983], [37.602, 30.226], [37.26, 32.822], [36.783, 35.396], [42.934, 39.753], [41.09, 45.427], [33.553, 45.337], [32.426, 47.7], [31.177, 50], [0, 32], [0.35, 31.356], [0.666, 30.694], [0.946, 30.017], [1.191, 29.326], [1.399, 28.623], [1.57, 27.911], [1.704, 27.19], [1.799, 26.463], [1.857, 25.733], [1.876, 25], [1.857, 24.267], [1.799, 23.537], [1.704, 22.81], [1.57, 22.089], [1.399, 21.377], [1.191, 20.674], [0.946, 19.983], [0.666, 19.306], [0.35, 18.644], [0, 18]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
