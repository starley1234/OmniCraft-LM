$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[52.985, 0], [53.903, 2.159], [54.748, 4.347], [63.066, 3.903], [64.463, 8.6], [57.254, 12.773], [57.742, 15.067], [58.152, 17.377], [66.401, 18.534], [66.873, 23.411], [58.998, 26.127], [59.037, 28.472], [58.998, 30.817], [66.873, 33.533], [66.401, 38.41], [58.152, 39.567], [57.742, 41.877], [57.254, 44.171], [64.463, 48.344], [63.066, 53.041], [54.748, 52.597], [53.903, 54.785], [52.985, 56.944], [0, 33.353], [0.24, 32.772], [0.45, 32.18], [0.628, 31.578], [0.775, 30.967], [0.889, 30.349], [0.971, 29.726], [1.021, 29.1], [1.037, 28.472], [1.021, 27.844], [0.971, 27.218], [0.889, 26.595], [0.775, 25.977], [0.628, 25.366], [0.45, 24.764], [0.24, 24.172], [0, 23.591]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
