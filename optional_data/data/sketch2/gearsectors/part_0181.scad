$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[56.015, 0], [57.162, 3.223], [58.151, 6.497], [64.934, 8.96], [66.255, 17.208], [60.58, 21.667], [60.664, 25.086], [60.58, 28.505], [66.255, 32.964], [64.934, 41.212], [58.151, 43.675], [57.162, 46.949], [56.015, 50.172], [0, 28.67], [0.175, 28.176], [0.323, 27.674], [0.445, 27.165], [0.541, 26.65], [0.609, 26.131], [0.65, 25.609], [0.664, 25.086], [0.65, 24.563], [0.609, 24.041], [0.541, 23.522], [0.445, 23.007], [0.323, 22.498], [0.175, 21.996], [0, 21.502]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
