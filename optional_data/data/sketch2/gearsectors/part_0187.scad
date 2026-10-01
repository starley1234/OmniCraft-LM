$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.945, 0], [43.551, 1.651], [44.109, 3.32], [52.274, 2.685], [53.21, 6.304], [45.759, 9.704], [46.079, 11.434], [46.349, 13.172], [54.506, 13.916], [54.82, 17.641], [46.904, 19.743], [46.93, 21.502], [46.904, 23.261], [54.82, 25.363], [54.506, 29.088], [46.349, 29.832], [46.079, 31.57], [45.759, 33.3], [53.21, 36.7], [52.274, 40.319], [44.109, 39.684], [43.551, 41.353], [42.945, 43.004], [0, 26.519], [0.245, 25.828], [0.453, 25.125], [0.624, 24.413], [0.758, 23.692], [0.853, 22.965], [0.911, 22.235], [0.93, 21.502], [0.911, 20.769], [0.853, 20.039], [0.758, 19.312], [0.624, 18.591], [0.453, 17.879], [0.245, 17.176], [0, 16.485]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
