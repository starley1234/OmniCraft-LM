$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[66.574, 0], [67.542, 3.207], [68.375, 6.453], [75.049, 9.049], [76.149, 17.076], [70.419, 21.371], [70.489, 24.721], [70.419, 28.071], [76.149, 32.366], [75.049, 40.393], [68.375, 42.989], [67.542, 46.235], [66.574, 49.442], [0, 27.811], [0.148, 27.309], [0.27, 26.8], [0.366, 26.285], [0.434, 25.766], [0.475, 25.244], [0.489, 24.721], [0.475, 24.198], [0.434, 23.676], [0.366, 23.157], [0.27, 22.642], [0.148, 22.133], [0, 21.631]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
