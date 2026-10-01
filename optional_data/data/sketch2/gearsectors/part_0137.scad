$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[65.35, 0], [66.159, 2.201], [66.902, 4.426], [73.306, 4.87], [74.488, 9.448], [69.102, 12.939], [69.53, 15.245], [69.889, 17.563], [76.127, 19.075], [76.525, 23.786], [70.63, 26.324], [70.664, 28.669], [70.63, 31.014], [76.525, 33.552], [76.127, 38.263], [69.889, 39.775], [69.53, 42.093], [69.102, 44.399], [74.488, 47.89], [73.306, 52.468], [66.902, 52.912], [66.159, 55.137], [65.35, 57.338], [0, 32.253], [0.175, 31.759], [0.323, 31.257], [0.445, 30.748], [0.541, 30.233], [0.609, 29.714], [0.65, 29.192], [0.664, 28.669], [0.65, 28.146], [0.609, 27.624], [0.541, 27.105], [0.445, 26.59], [0.323, 26.081], [0.175, 25.579], [0, 25.085]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
