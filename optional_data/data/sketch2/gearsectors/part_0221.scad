$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[60.622, 0], [62.621, 3.681], [64.424, 7.461], [71.628, 9.18], [74.41, 17.742], [69.592, 23.367], [70.355, 27.485], [70.902, 31.638], [77.222, 35.499], [77.222, 44.501], [70.902, 48.362], [70.355, 52.515], [69.592, 56.633], [74.41, 62.258], [71.628, 70.82], [64.424, 72.539], [62.621, 76.319], [60.622, 80], [0, 45], [0.25, 44.54], [0.475, 44.067], [0.676, 43.584], [0.851, 43.09], [0.999, 42.588], [1.121, 42.079], [1.217, 41.564], [1.285, 41.045], [1.326, 40.523], [1.34, 40], [1.326, 39.477], [1.285, 38.955], [1.217, 38.436], [1.121, 37.921], [0.999, 37.412], [0.851, 36.91], [0.676, 36.416], [0.475, 35.933], [0.25, 35.46], [0, 35]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
