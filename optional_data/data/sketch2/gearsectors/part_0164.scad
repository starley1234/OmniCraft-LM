$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[51.962, 0], [53.525, 2.858], [54.953, 5.786], [56.243, 8.778], [63.822, 12.146], [66.505, 23.766], [61.169, 30.117], [61.321, 33.371], [61.321, 36.629], [61.169, 39.883], [66.505, 46.234], [63.822, 57.854], [56.243, 61.222], [54.953, 64.214], [53.525, 67.142], [51.962, 70], [0, 40], [0.25, 39.54], [0.475, 39.067], [0.676, 38.584], [0.851, 38.09], [0.999, 37.588], [1.121, 37.079], [1.217, 36.564], [1.285, 36.045], [1.326, 35.523], [1.34, 35], [1.326, 34.477], [1.285, 33.955], [1.217, 33.436], [1.121, 32.921], [0.999, 32.412], [0.851, 31.91], [0.676, 31.416], [0.475, 30.933], [0.25, 30.46], [0, 30]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
