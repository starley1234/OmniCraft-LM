$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[57.158, 0], [58.944, 3.267], [60.576, 6.613], [62.051, 10.031], [68.942, 14.44], [71.942, 27.436], [67.681, 34.419], [67.854, 38.138], [67.854, 41.862], [67.681, 45.581], [71.942, 52.564], [68.942, 65.56], [62.051, 69.969], [60.576, 73.387], [58.944, 76.733], [57.158, 80], [0, 47], [0.35, 46.356], [0.666, 45.694], [0.946, 45.017], [1.191, 44.326], [1.399, 43.623], [1.57, 42.911], [1.704, 42.19], [1.799, 41.463], [1.857, 40.733], [1.876, 40], [1.857, 39.267], [1.799, 38.537], [1.704, 37.81], [1.57, 37.089], [1.399, 36.377], [1.191, 35.674], [0.946, 34.983], [0.666, 34.306], [0.35, 33.644], [0, 33]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
