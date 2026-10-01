$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[62.371, 0], [63.689, 2.712], [64.904, 5.472], [71.562, 5.983], [73.504, 11.743], [68.514, 16.18], [69.218, 19.113], [69.811, 22.07], [76.203, 24.001], [76.861, 30.043], [71.033, 33.304], [71.09, 36.319], [71.033, 39.334], [76.861, 42.595], [76.203, 48.637], [69.811, 50.568], [69.218, 53.525], [68.514, 56.458], [73.504, 60.895], [71.562, 66.655], [64.904, 67.166], [63.689, 69.926], [62.371, 72.638], [0, 40.859], [0.225, 40.386], [0.426, 39.903], [0.601, 39.409], [0.749, 38.907], [0.871, 38.398], [0.967, 37.883], [1.035, 37.364], [1.076, 36.842], [1.09, 36.319], [1.076, 35.796], [1.035, 35.274], [0.967, 34.755], [0.871, 34.24], [0.749, 33.731], [0.601, 33.229], [0.426, 32.735], [0.225, 32.252], [0, 31.779]];  // primary outline, 42 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
