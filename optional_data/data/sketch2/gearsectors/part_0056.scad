$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[32.076, 0], [33.096, 2.124], [34.015, 4.294], [42.399, 3.913], [43.923, 9.16], [36.64, 13.331], [37.027, 15.655], [37.304, 17.995], [45.462, 19.968], [45.462, 25.432], [37.304, 27.405], [37.027, 29.745], [36.64, 32.069], [43.923, 36.24], [42.399, 41.487], [34.015, 41.106], [33.096, 43.276], [32.076, 45.4], [0, 29.056], [0.316, 28.394], [0.596, 27.717], [0.841, 27.026], [1.049, 26.323], [1.22, 25.611], [1.354, 24.89], [1.449, 24.163], [1.507, 23.433], [1.526, 22.7], [1.507, 21.967], [1.449, 21.237], [1.354, 20.51], [1.22, 19.789], [1.049, 19.077], [0.841, 18.374], [0.596, 17.683], [0.316, 17.006], [0, 16.344]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
