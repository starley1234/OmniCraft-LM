$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[45.678, 0], [46.548, 2.057], [47.341, 4.145], [48.056, 6.262], [53.934, 8.679], [55.408, 16.708], [50.771, 21.055], [50.855, 23.287], [50.855, 25.521], [50.771, 27.753], [55.408, 32.1], [53.934, 40.129], [48.056, 42.546], [47.341, 44.663], [46.548, 46.751], [45.678, 48.808], [0, 28.471], [0.201, 27.988], [0.376, 27.494], [0.524, 26.992], [0.646, 26.483], [0.742, 25.968], [0.81, 25.449], [0.851, 24.927], [0.865, 24.404], [0.851, 23.881], [0.81, 23.359], [0.742, 22.84], [0.646, 22.325], [0.524, 21.816], [0.376, 21.314], [0.201, 20.82], [0, 20.337]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
