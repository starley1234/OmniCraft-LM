$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.945, 0], [43.551, 1.651], [44.109, 3.32], [49.392, 3.515], [50.286, 6.974], [45.759, 9.704], [46.079, 11.434], [46.349, 13.172], [51.524, 14.251], [51.825, 17.811], [46.904, 19.743], [46.93, 21.502], [46.904, 23.261], [51.825, 25.193], [51.524, 28.753], [46.349, 29.832], [46.079, 31.57], [45.759, 33.3], [50.286, 36.03], [49.392, 39.489], [44.109, 39.684], [43.551, 41.353], [42.945, 43.004], [0, 26.519], [0.245, 25.828], [0.453, 25.125], [0.624, 24.413], [0.758, 23.692], [0.853, 22.965], [0.911, 22.235], [0.93, 21.502], [0.911, 20.769], [0.853, 20.039], [0.758, 19.312], [0.624, 18.591], [0.453, 17.879], [0.245, 17.176], [0, 16.485]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
