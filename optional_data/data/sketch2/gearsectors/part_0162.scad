$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[43.85, 0], [44.72, 2.057], [45.513, 4.145], [46.228, 6.262], [52.106, 8.679], [53.58, 16.708], [48.943, 21.055], [49.027, 23.287], [49.027, 25.521], [48.943, 27.753], [53.58, 32.1], [52.106, 40.129], [46.228, 42.546], [45.513, 44.663], [44.72, 46.751], [43.85, 48.808], [0, 29.285], [0.24, 28.704], [0.45, 28.112], [0.628, 27.51], [0.775, 26.899], [0.889, 26.281], [0.971, 25.658], [1.021, 25.032], [1.037, 24.404], [1.021, 23.776], [0.971, 23.15], [0.889, 22.527], [0.775, 21.909], [0.628, 21.298], [0.45, 20.696], [0.24, 20.104], [0, 19.523]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
