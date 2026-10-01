$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[35.64, 0], [36.552, 1.886], [37.384, 3.808], [38.134, 5.763], [44.025, 7.771], [45.6, 15.378], [40.991, 19.56], [41.079, 21.653], [41.079, 23.747], [40.991, 25.84], [45.6, 30.022], [44.025, 37.629], [38.134, 39.637], [37.384, 41.592], [36.552, 43.514], [35.64, 45.4], [0, 27.24], [0.225, 26.767], [0.426, 26.284], [0.601, 25.79], [0.749, 25.288], [0.871, 24.779], [0.967, 24.264], [1.035, 23.745], [1.076, 23.223], [1.09, 22.7], [1.076, 22.177], [1.035, 21.655], [0.967, 21.136], [0.871, 20.621], [0.749, 20.112], [0.601, 19.61], [0.426, 19.116], [0.225, 18.633], [0, 18.16]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
