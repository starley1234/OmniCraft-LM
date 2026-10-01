$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[44.812, 0], [45.418, 1.651], [45.976, 3.32], [53.181, 2.961], [54.102, 6.527], [47.626, 9.704], [47.946, 11.434], [48.216, 13.172], [55.379, 14.028], [55.689, 17.698], [48.771, 19.743], [48.797, 21.502], [48.771, 23.261], [55.689, 25.306], [55.379, 28.976], [48.216, 29.832], [47.946, 31.57], [47.626, 33.3], [54.102, 36.477], [53.181, 40.043], [45.976, 39.684], [45.418, 41.353], [44.812, 43.004], [0, 25.802], [0.21, 25.21], [0.388, 24.608], [0.535, 23.997], [0.649, 23.379], [0.731, 22.756], [0.781, 22.13], [0.797, 21.502], [0.781, 20.874], [0.731, 20.248], [0.649, 19.625], [0.535, 19.007], [0.388, 18.396], [0.21, 17.794], [0, 17.202]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
