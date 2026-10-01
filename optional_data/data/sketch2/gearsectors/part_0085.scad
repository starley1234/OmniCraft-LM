$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[43.85, 0], [44.637, 1.85], [45.361, 3.725], [53.576, 2.985], [54.793, 7.08], [47.509, 10.948], [47.927, 12.914], [48.279, 14.894], [56.483, 15.74], [56.894, 19.992], [49.003, 22.394], [49.037, 24.404], [49.003, 26.414], [56.894, 28.816], [56.483, 33.068], [48.279, 33.914], [47.927, 35.894], [47.509, 37.86], [54.793, 41.728], [53.576, 45.823], [45.361, 45.083], [44.637, 46.958], [43.85, 48.808], [0, 29.285], [0.24, 28.704], [0.45, 28.112], [0.628, 27.51], [0.775, 26.899], [0.889, 26.281], [0.971, 25.658], [1.021, 25.032], [1.037, 24.404], [1.021, 23.776], [0.971, 23.15], [0.889, 22.527], [0.775, 21.909], [0.628, 21.298], [0.45, 20.696], [0.24, 20.104], [0, 19.523]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
