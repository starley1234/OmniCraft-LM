$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[41.57, 0], [43.068, 2.761], [44.421, 5.596], [51.224, 6.348], [53.359, 12.918], [48.297, 17.525], [48.869, 20.614], [49.279, 23.728], [55.518, 26.546], [55.518, 33.454], [49.279, 36.272], [48.869, 39.386], [48.297, 42.475], [53.359, 47.082], [51.224, 53.652], [44.421, 54.404], [43.068, 57.239], [41.57, 60], [0, 36], [0.3, 35.448], [0.571, 34.881], [0.811, 34.3], [1.021, 33.708], [1.199, 33.106], [1.346, 32.495], [1.46, 31.877], [1.542, 31.254], [1.592, 30.628], [1.608, 30], [1.592, 29.372], [1.542, 28.746], [1.46, 28.123], [1.346, 27.505], [1.199, 26.894], [1.021, 26.292], [0.811, 25.7], [0.571, 25.119], [0.3, 24.552], [0, 24]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
