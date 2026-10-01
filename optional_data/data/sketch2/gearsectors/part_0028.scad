$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[58.89, 0], [60.504, 2.936], [61.994, 5.938], [68.801, 6.466], [71.188, 12.783], [66.431, 17.681], [67.299, 20.917], [68.03, 24.187], [74.514, 26.324], [75.325, 33.028], [69.538, 36.65], [69.608, 40], [69.538, 43.35], [75.325, 46.972], [74.514, 53.676], [68.03, 55.813], [67.299, 59.083], [66.431, 62.319], [71.188, 67.217], [68.801, 73.534], [61.994, 74.062], [60.504, 77.064], [58.89, 80], [0, 46], [0.3, 45.448], [0.571, 44.881], [0.811, 44.3], [1.021, 43.708], [1.199, 43.106], [1.346, 42.495], [1.46, 41.877], [1.542, 41.254], [1.592, 40.628], [1.608, 40], [1.592, 39.372], [1.542, 38.746], [1.46, 38.123], [1.346, 37.505], [1.199, 36.894], [1.021, 36.292], [0.811, 35.7], [0.571, 35.119], [0.3, 34.552], [0, 34]];  // primary outline, 44 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
