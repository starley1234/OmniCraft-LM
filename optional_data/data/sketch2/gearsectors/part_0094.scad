$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.023, 0], [42.893, 2.057], [43.686, 4.145], [44.401, 6.262], [53.19, 7.953], [54.732, 16.353], [47.116, 21.055], [47.2, 23.287], [47.2, 25.521], [47.116, 27.753], [54.732, 32.455], [53.19, 40.855], [44.401, 42.546], [43.686, 44.663], [42.893, 46.751], [42.023, 48.808], [0, 30.098], [0.28, 29.421], [0.525, 28.73], [0.733, 28.027], [0.904, 27.315], [1.038, 26.594], [1.133, 25.867], [1.191, 25.137], [1.21, 24.404], [1.191, 23.671], [1.133, 22.941], [1.038, 22.214], [0.904, 21.493], [0.733, 20.781], [0.525, 20.078], [0.28, 19.387], [0, 18.71]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
