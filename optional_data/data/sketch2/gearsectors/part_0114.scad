$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[56.015, 0], [56.722, 1.927], [57.373, 3.874], [64.657, 3.778], [65.716, 7.876], [59.297, 11.322], [59.671, 13.34], [59.986, 15.368], [67.183, 16.496], [67.54, 20.714], [60.634, 23.034], [60.664, 25.086], [60.634, 27.138], [67.54, 29.458], [67.183, 33.676], [59.986, 34.804], [59.671, 36.832], [59.297, 38.85], [65.716, 42.296], [64.657, 46.394], [57.373, 46.298], [56.722, 48.245], [56.015, 50.172], [0, 28.67], [0.175, 28.176], [0.323, 27.674], [0.445, 27.165], [0.541, 26.65], [0.609, 26.131], [0.65, 25.609], [0.664, 25.086], [0.65, 24.563], [0.609, 24.041], [0.541, 23.522], [0.445, 23.007], [0.323, 22.498], [0.175, 21.996], [0, 21.502]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
