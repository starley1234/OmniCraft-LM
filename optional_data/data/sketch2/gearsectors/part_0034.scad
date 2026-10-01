$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[51.158, 0], [52.076, 2.159], [52.921, 4.347], [59.341, 4.533], [60.702, 9.109], [55.427, 12.773], [55.915, 15.067], [56.325, 17.377], [62.591, 18.789], [63.05, 23.541], [57.171, 26.127], [57.21, 28.472], [57.171, 30.817], [63.05, 33.403], [62.591, 38.155], [56.325, 39.567], [55.915, 41.877], [55.427, 44.171], [60.702, 47.835], [59.341, 52.411], [52.921, 52.597], [52.076, 54.785], [51.158, 56.944], [0, 34.166], [0.28, 33.489], [0.525, 32.798], [0.733, 32.095], [0.904, 31.383], [1.038, 30.662], [1.133, 29.935], [1.191, 29.205], [1.21, 28.472], [1.191, 27.739], [1.133, 27.009], [1.038, 26.282], [0.904, 25.561], [0.733, 24.849], [0.525, 24.146], [0.28, 23.455], [0, 22.778]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
