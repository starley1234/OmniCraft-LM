$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[32.076, 0], [32.988, 1.886], [33.82, 3.808], [34.57, 5.763], [43.348, 6.956], [45.01, 14.979], [37.427, 19.56], [37.515, 21.653], [37.515, 23.747], [37.427, 25.84], [45.01, 30.421], [43.348, 38.444], [34.57, 39.637], [33.82, 41.592], [32.988, 43.514], [32.076, 45.4], [0, 29.056], [0.316, 28.394], [0.596, 27.717], [0.841, 27.026], [1.049, 26.323], [1.22, 25.611], [1.354, 24.89], [1.449, 24.163], [1.507, 23.433], [1.526, 22.7], [1.507, 21.967], [1.449, 21.237], [1.354, 20.51], [1.22, 19.789], [1.049, 19.077], [0.841, 18.374], [0.596, 17.683], [0.316, 17.006], [0, 16.344]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
