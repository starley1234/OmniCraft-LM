$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[60.589, 0], [62.22, 3.398], [63.69, 6.869], [72.564, 7.814], [74.877, 15.776], [67.891, 21.328], [68.51, 25.047], [68.953, 28.79], [77.21, 32.174], [77.21, 40.464], [68.953, 43.848], [68.51, 47.591], [67.891, 51.31], [74.877, 56.862], [72.564, 64.824], [63.69, 65.769], [62.22, 69.24], [60.589, 72.638], [0, 41.767], [0.271, 41.2], [0.511, 40.619], [0.721, 40.027], [0.899, 39.425], [1.046, 38.814], [1.16, 38.196], [1.242, 37.573], [1.292, 36.947], [1.308, 36.319], [1.292, 35.691], [1.242, 35.065], [1.16, 34.442], [1.046, 33.824], [0.899, 33.213], [0.721, 32.611], [0.511, 32.019], [0.271, 31.438], [0, 30.871]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
