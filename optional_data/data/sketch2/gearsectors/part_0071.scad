$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.023, 0], [42.81, 1.85], [43.534, 3.725], [48.901, 3.93], [50.065, 7.844], [45.682, 10.948], [46.1, 12.914], [46.452, 14.894], [51.68, 16.122], [52.073, 20.187], [47.176, 22.394], [47.21, 24.404], [47.176, 26.414], [52.073, 28.621], [51.68, 32.686], [46.452, 33.914], [46.1, 35.894], [45.682, 37.86], [50.065, 40.964], [48.901, 44.878], [43.534, 45.083], [42.81, 46.958], [42.023, 48.808], [0, 30.098], [0.28, 29.421], [0.525, 28.73], [0.733, 28.027], [0.904, 27.315], [1.038, 26.594], [1.133, 25.867], [1.191, 25.137], [1.21, 24.404], [1.191, 23.671], [1.133, 22.941], [1.038, 22.214], [0.904, 21.493], [0.733, 20.781], [0.525, 20.078], [0.28, 19.387], [0, 18.71]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
