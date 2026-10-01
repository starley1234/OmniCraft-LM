$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[57.063, 0], [58.066, 3.372], [64.305, 3.541], [65.075, 7.038], [59.484, 9.813], [59.991, 13.294], [66.14, 14.36], [66.399, 17.932], [60.467, 19.872], [60.467, 23.39], [66.399, 25.33], [66.14, 28.902], [59.991, 29.968], [59.484, 33.449], [65.075, 36.224], [64.305, 39.721], [58.066, 39.89], [57.063, 43.262], [0, 24.721], [0.148, 24.219], [0.27, 23.71], [0.366, 23.195], [0.434, 22.676], [0.475, 22.154], [0.489, 21.631], [0.475, 21.108], [0.434, 20.586], [0.366, 20.067], [0.27, 19.552], [0.148, 19.043], [0, 18.541]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
