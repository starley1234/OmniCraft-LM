$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[53.46, 0], [54.888, 2.973], [56.174, 6.01], [62.046, 7.485], [64.018, 14.271], [59.85, 18.662], [60.392, 21.916], [60.779, 25.191], [66.007, 28.246], [66.007, 35.312], [60.779, 38.367], [60.392, 41.642], [59.85, 44.896], [64.018, 49.287], [62.046, 56.073], [56.174, 57.548], [54.888, 60.585], [53.46, 63.558], [0, 36.319], [0.225, 35.846], [0.426, 35.363], [0.601, 34.869], [0.749, 34.367], [0.871, 33.858], [0.967, 33.343], [1.035, 32.824], [1.076, 32.302], [1.09, 31.779], [1.076, 31.256], [1.035, 30.734], [0.967, 30.215], [0.871, 29.7], [0.749, 29.191], [0.601, 28.689], [0.426, 28.195], [0.225, 27.712], [0, 27.239]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
