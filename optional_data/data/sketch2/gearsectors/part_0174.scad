$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[64.672, 0], [65.64, 3.207], [66.473, 6.453], [75.113, 8.684], [76.239, 16.898], [68.517, 21.371], [68.587, 24.721], [68.517, 28.071], [76.239, 32.544], [75.113, 40.758], [66.473, 42.989], [65.64, 46.235], [64.672, 49.442], [0, 28.429], [0.178, 27.827], [0.325, 27.216], [0.439, 26.598], [0.521, 25.975], [0.571, 25.349], [0.587, 24.721], [0.571, 24.093], [0.521, 23.467], [0.439, 22.844], [0.325, 22.226], [0.178, 21.615], [0, 21.013]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
