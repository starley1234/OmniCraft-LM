$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[35.476, 0], [35.981, 1.376], [36.446, 2.766], [42.61, 2.421], [43.38, 5.402], [37.821, 8.086], [38.088, 9.528], [38.313, 10.977], [44.447, 11.671], [44.707, 14.738], [38.776, 16.452], [38.797, 17.918], [38.776, 19.384], [44.707, 21.098], [44.447, 24.165], [38.313, 24.859], [38.088, 26.308], [37.821, 27.75], [43.38, 30.434], [42.61, 33.415], [36.446, 33.07], [35.981, 34.46], [35.476, 35.836], [0, 22.218], [0.21, 21.626], [0.388, 21.024], [0.535, 20.413], [0.649, 19.795], [0.731, 19.172], [0.781, 18.546], [0.797, 17.918], [0.781, 17.29], [0.731, 16.664], [0.649, 16.041], [0.535, 15.423], [0.388, 14.812], [0.21, 14.21], [0, 13.618]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
