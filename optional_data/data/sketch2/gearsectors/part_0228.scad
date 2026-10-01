$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.945, 0], [43.695, 2.067], [44.369, 4.16], [49.802, 5.008], [50.842, 9.657], [46.286, 12.737], [46.568, 14.918], [46.769, 17.108], [51.886, 19.12], [51.886, 23.884], [46.769, 25.896], [46.568, 28.086], [46.286, 30.267], [50.842, 33.347], [49.802, 37.996], [44.369, 38.844], [43.695, 40.937], [42.945, 43.004], [0, 26.519], [0.245, 25.828], [0.453, 25.125], [0.624, 24.413], [0.758, 23.692], [0.853, 22.965], [0.911, 22.235], [0.93, 21.502], [0.911, 20.769], [0.853, 20.039], [0.758, 19.312], [0.624, 18.591], [0.453, 17.879], [0.245, 17.176], [0, 16.485]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
