$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[53.259, 0], [54.262, 3.372], [61.472, 3.303], [62.252, 6.846], [55.68, 9.813], [56.187, 13.294], [63.332, 14.264], [63.594, 17.883], [56.663, 19.872], [56.663, 23.39], [63.594, 25.379], [63.332, 28.998], [56.187, 29.968], [55.68, 33.449], [62.252, 36.416], [61.472, 39.959], [54.262, 39.89], [53.259, 43.262], [0, 25.957], [0.208, 25.254], [0.379, 24.542], [0.513, 23.821], [0.608, 23.094], [0.666, 22.364], [0.685, 21.631], [0.666, 20.898], [0.608, 20.168], [0.513, 19.441], [0.379, 18.72], [0.208, 18.008], [0, 17.305]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
