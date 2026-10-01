$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[32.076, 0], [32.9, 1.696], [33.66, 3.421], [39.926, 2.947], [41.191, 6.697], [35.916, 10.113], [36.356, 11.946], [36.726, 13.794], [42.949, 14.679], [43.377, 18.613], [37.49, 20.815], [37.526, 22.7], [37.49, 24.585], [43.377, 26.787], [42.949, 30.721], [36.726, 31.606], [36.356, 33.454], [35.916, 35.287], [41.191, 38.703], [39.926, 42.453], [33.66, 41.979], [32.9, 43.704], [32.076, 45.4], [0, 29.056], [0.316, 28.394], [0.596, 27.717], [0.841, 27.026], [1.049, 26.323], [1.22, 25.611], [1.354, 24.89], [1.449, 24.163], [1.507, 23.433], [1.526, 22.7], [1.507, 21.967], [1.449, 21.237], [1.354, 20.51], [1.22, 19.789], [1.049, 19.077], [0.841, 18.374], [0.596, 17.683], [0.316, 17.006], [0, 16.344]];  // primary outline, 42 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
