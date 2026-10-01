$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[32.909, 0], [34.158, 2.3], [35.285, 4.663], [41.889, 4.931], [43.7, 10.506], [38.515, 14.604], [38.992, 17.178], [39.334, 19.774], [45.531, 22.069], [45.531, 27.931], [39.334, 30.226], [38.992, 32.822], [38.515, 35.396], [43.7, 39.494], [41.889, 45.069], [35.285, 45.337], [34.158, 47.7], [32.909, 50], [0, 31], [0.3, 30.448], [0.571, 29.881], [0.811, 29.3], [1.021, 28.708], [1.199, 28.106], [1.346, 27.495], [1.46, 26.877], [1.542, 26.254], [1.592, 25.628], [1.608, 25], [1.592, 24.372], [1.542, 23.746], [1.46, 23.123], [1.346, 22.505], [1.199, 21.894], [1.021, 21.292], [0.811, 20.7], [0.571, 20.119], [0.3, 19.552], [0, 19]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
