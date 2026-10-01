$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[41.57, 0], [42.909, 2.45], [44.133, 4.96], [45.239, 7.524], [52.553, 10.153], [54.883, 20.245], [49.462, 25.815], [49.592, 28.604], [49.592, 31.396], [49.462, 34.185], [54.883, 39.755], [52.553, 49.847], [45.239, 52.476], [44.133, 55.04], [42.909, 57.55], [41.57, 60], [0, 36], [0.3, 35.448], [0.571, 34.881], [0.811, 34.3], [1.021, 33.708], [1.199, 33.106], [1.346, 32.495], [1.46, 31.877], [1.542, 31.254], [1.592, 30.628], [1.608, 30], [1.592, 29.372], [1.542, 28.746], [1.46, 28.123], [1.346, 27.505], [1.199, 26.894], [1.021, 26.292], [0.811, 25.7], [0.571, 25.119], [0.3, 24.552], [0, 24]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
