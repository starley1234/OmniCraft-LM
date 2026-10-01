$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[43.85, 0], [44.824, 2.317], [45.7, 4.672], [52.22, 5.328], [53.595, 10.682], [48.197, 14.398], [48.564, 16.884], [48.827, 19.383], [54.979, 21.64], [54.979, 27.168], [48.827, 29.425], [48.564, 31.924], [48.197, 34.41], [53.595, 38.126], [52.22, 43.48], [45.7, 44.136], [44.824, 46.491], [43.85, 48.808], [0, 29.285], [0.24, 28.704], [0.45, 28.112], [0.628, 27.51], [0.775, 26.899], [0.889, 26.281], [0.971, 25.658], [1.021, 25.032], [1.037, 24.404], [1.021, 23.776], [0.971, 23.15], [0.889, 22.527], [0.775, 21.909], [0.628, 21.298], [0.45, 20.696], [0.24, 20.104], [0, 19.523]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
