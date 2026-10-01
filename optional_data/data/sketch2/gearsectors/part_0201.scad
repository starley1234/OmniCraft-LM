$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.768, 0], [43.992, 2.548], [45.095, 5.152], [53.642, 5.213], [55.429, 11.365], [48.245, 15.996], [48.709, 18.785], [49.042, 21.593], [57.233, 24.036], [57.233, 30.442], [49.042, 32.885], [48.709, 35.693], [48.245, 38.482], [55.429, 43.113], [53.642, 49.265], [45.095, 49.326], [43.992, 51.93], [42.768, 54.478], [0, 32.687], [0.271, 32.12], [0.511, 31.539], [0.721, 30.947], [0.899, 30.345], [1.046, 29.734], [1.16, 29.116], [1.242, 28.493], [1.292, 27.867], [1.308, 27.239], [1.292, 26.611], [1.242, 25.985], [1.16, 25.362], [1.046, 24.744], [0.899, 24.133], [0.721, 23.531], [0.511, 22.939], [0.271, 22.358], [0, 21.791]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
