$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[32.909, 0], [34.026, 2.042], [35.046, 4.133], [35.967, 6.27], [43.97, 7.86], [45.982, 16.575], [39.486, 21.512], [39.594, 23.837], [39.594, 26.163], [39.486, 28.488], [45.982, 33.425], [43.97, 42.14], [35.967, 43.73], [35.046, 45.867], [34.026, 47.958], [32.909, 50], [0, 31], [0.3, 30.448], [0.571, 29.881], [0.811, 29.3], [1.021, 28.708], [1.199, 28.106], [1.346, 27.495], [1.46, 26.877], [1.542, 26.254], [1.592, 25.628], [1.608, 25], [1.592, 24.372], [1.542, 23.746], [1.46, 23.123], [1.346, 22.505], [1.199, 21.894], [1.021, 21.292], [0.811, 20.7], [0.571, 20.119], [0.3, 19.552], [0, 19]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
