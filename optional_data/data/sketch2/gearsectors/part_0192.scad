$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[52.985, 0], [54.121, 2.703], [55.143, 5.451], [61.793, 6.506], [63.376, 12.671], [58.057, 16.798], [58.485, 19.699], [58.792, 22.615], [64.97, 25.289], [64.97, 31.655], [58.792, 34.329], [58.485, 37.245], [58.057, 40.146], [63.376, 44.273], [61.793, 50.438], [55.143, 51.493], [54.121, 54.241], [52.985, 56.944], [0, 33.353], [0.24, 32.772], [0.45, 32.18], [0.628, 31.578], [0.775, 30.967], [0.889, 30.349], [0.971, 29.726], [1.021, 29.1], [1.037, 28.472], [1.021, 27.844], [0.971, 27.218], [0.889, 26.595], [0.775, 25.977], [0.628, 25.366], [0.45, 24.764], [0.24, 24.172], [0, 23.591]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
