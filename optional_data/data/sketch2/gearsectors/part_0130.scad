$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.945, 0], [43.928, 2.762], [44.776, 5.569], [53.382, 7.074], [54.564, 14.453], [46.858, 18.571], [46.93, 21.502], [46.858, 24.433], [54.564, 28.551], [53.382, 35.93], [44.776, 37.435], [43.928, 40.242], [42.945, 43.004], [0, 26.519], [0.245, 25.828], [0.453, 25.125], [0.624, 24.413], [0.758, 23.692], [0.853, 22.965], [0.911, 22.235], [0.93, 21.502], [0.911, 20.769], [0.853, 20.039], [0.758, 19.312], [0.624, 18.591], [0.453, 17.879], [0.245, 17.176], [0, 16.485]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
