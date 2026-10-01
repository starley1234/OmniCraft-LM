$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[53.46, 0], [54.737, 2.639], [55.901, 5.33], [56.952, 8.067], [65.199, 10.878], [67.405, 21.529], [60.952, 27.384], [61.075, 30.313], [61.075, 33.245], [60.952, 36.174], [67.405, 42.029], [65.199, 52.68], [56.952, 55.491], [55.901, 58.228], [54.737, 60.919], [53.46, 63.558], [0, 36.319], [0.225, 35.846], [0.426, 35.363], [0.601, 34.869], [0.749, 34.367], [0.871, 33.858], [0.967, 33.343], [1.035, 32.824], [1.076, 32.302], [1.09, 31.779], [1.076, 31.256], [1.035, 30.734], [0.967, 30.215], [0.871, 29.7], [0.749, 29.191], [0.601, 28.689], [0.426, 28.195], [0.225, 27.712], [0, 27.239]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
