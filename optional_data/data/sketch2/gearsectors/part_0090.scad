$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[57.063, 0], [57.71, 2.102], [58.29, 4.223], [66.611, 4.616], [67.529, 9.429], [59.937, 12.858], [60.178, 15.043], [60.351, 17.236], [68.451, 19.181], [68.451, 24.081], [60.351, 26.026], [60.178, 28.219], [59.937, 30.404], [67.529, 33.833], [66.611, 38.646], [58.29, 39.039], [57.71, 41.16], [57.063, 43.262], [0, 24.721], [0.148, 24.219], [0.27, 23.71], [0.366, 23.195], [0.434, 22.676], [0.475, 22.154], [0.489, 21.631], [0.475, 21.108], [0.434, 20.586], [0.366, 20.067], [0.27, 19.552], [0.148, 19.043], [0, 18.541]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
