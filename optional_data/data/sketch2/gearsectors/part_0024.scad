$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[52.985, 0], [54.001, 2.401], [54.926, 4.837], [55.76, 7.306], [62.779, 10.086], [64.502, 19.473], [58.928, 24.564], [59.025, 27.169], [59.025, 29.775], [58.928, 32.38], [64.502, 37.471], [62.779, 46.858], [55.76, 49.638], [54.926, 52.107], [54.001, 54.543], [52.985, 56.944], [0, 33.353], [0.24, 32.772], [0.45, 32.18], [0.628, 31.578], [0.775, 30.967], [0.889, 30.349], [0.971, 29.726], [1.021, 29.1], [1.037, 28.472], [1.021, 27.844], [0.971, 27.218], [0.889, 26.595], [0.775, 25.977], [0.628, 25.366], [0.45, 24.764], [0.24, 24.172], [0, 23.591]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
