$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[58.89, 0], [60.676, 3.267], [62.308, 6.613], [63.783, 10.031], [71.628, 14.139], [74.663, 27.288], [69.413, 34.419], [69.586, 38.138], [69.586, 41.862], [69.413, 45.581], [74.663, 52.712], [71.628, 65.861], [63.783, 69.969], [62.308, 73.387], [60.676, 76.733], [58.89, 80], [0, 46], [0.3, 45.448], [0.571, 44.881], [0.811, 44.3], [1.021, 43.708], [1.199, 43.106], [1.346, 42.495], [1.46, 41.877], [1.542, 41.254], [1.592, 40.628], [1.608, 40], [1.592, 39.372], [1.542, 38.746], [1.46, 38.123], [1.346, 37.505], [1.199, 36.894], [1.021, 36.292], [0.811, 35.7], [0.571, 35.119], [0.3, 34.552], [0, 34]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
