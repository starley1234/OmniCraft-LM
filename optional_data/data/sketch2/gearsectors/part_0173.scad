$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[48.498, 0], [50.246, 3.221], [51.824, 6.528], [58.828, 7.764], [61.286, 15.33], [56.346, 20.446], [57.014, 24.05], [57.493, 27.683], [63.772, 31.022], [63.772, 38.978], [57.493, 42.317], [57.014, 45.95], [56.346, 49.554], [61.286, 54.67], [58.828, 62.236], [51.824, 63.472], [50.246, 66.779], [48.498, 70], [0, 42], [0.35, 41.356], [0.666, 40.694], [0.946, 40.017], [1.191, 39.326], [1.399, 38.623], [1.57, 37.911], [1.704, 37.19], [1.799, 36.463], [1.857, 35.733], [1.876, 35], [1.857, 34.267], [1.799, 33.537], [1.704, 32.81], [1.57, 32.089], [1.399, 31.377], [1.191, 30.674], [0.946, 29.983], [0.666, 29.306], [0.35, 28.644], [0, 28]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
