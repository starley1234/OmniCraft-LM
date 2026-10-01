$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[64.672, 0], [65.41, 2.402], [66.074, 4.826], [74.468, 5.524], [75.504, 10.955], [67.956, 14.694], [68.232, 17.192], [68.429, 19.698], [76.544, 21.957], [76.544, 27.485], [68.429, 29.744], [68.232, 32.25], [67.956, 34.748], [75.504, 38.487], [74.468, 43.918], [66.074, 44.616], [65.41, 47.04], [64.672, 49.442], [0, 28.429], [0.178, 27.827], [0.325, 27.216], [0.439, 26.598], [0.521, 25.975], [0.571, 25.349], [0.587, 24.721], [0.571, 24.093], [0.521, 23.467], [0.439, 22.844], [0.325, 22.226], [0.178, 21.615], [0, 21.013]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
