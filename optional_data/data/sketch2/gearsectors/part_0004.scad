$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.023, 0], [42.997, 2.317], [43.873, 4.672], [51.35, 5.039], [52.746, 10.474], [46.37, 14.398], [46.737, 16.884], [47, 19.383], [54.151, 21.598], [54.151, 27.21], [47, 29.425], [46.737, 31.924], [46.37, 34.41], [52.746, 38.334], [51.35, 43.769], [43.873, 44.136], [42.997, 46.491], [42.023, 48.808], [0, 30.098], [0.28, 29.421], [0.525, 28.73], [0.733, 28.027], [0.904, 27.315], [1.038, 26.594], [1.133, 25.867], [1.191, 25.137], [1.21, 24.404], [1.191, 23.671], [1.133, 22.941], [1.038, 22.214], [0.904, 21.493], [0.733, 20.781], [0.525, 20.078], [0.28, 19.387], [0, 18.71]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
