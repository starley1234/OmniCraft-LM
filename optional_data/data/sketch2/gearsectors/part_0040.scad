$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[60.589, 0], [62.047, 3.017], [63.378, 6.092], [64.578, 9.22], [73.042, 12.704], [75.534, 24.737], [69.15, 31.296], [69.29, 34.644], [69.29, 37.994], [69.15, 41.342], [75.534, 47.901], [73.042, 59.934], [64.578, 63.418], [63.378, 66.546], [62.047, 69.621], [60.589, 72.638], [0, 41.767], [0.271, 41.2], [0.511, 40.619], [0.721, 40.027], [0.899, 39.425], [1.046, 38.814], [1.16, 38.196], [1.242, 37.573], [1.292, 36.947], [1.308, 36.319], [1.292, 35.691], [1.242, 35.065], [1.16, 34.442], [1.046, 33.824], [0.899, 33.213], [0.721, 32.611], [0.511, 32.019], [0.271, 31.438], [0, 30.871]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
