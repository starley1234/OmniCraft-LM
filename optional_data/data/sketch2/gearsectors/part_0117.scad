$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[38.042, 0], [38.647, 2.005], [39.168, 4.033], [47.518, 4.881], [48.259, 10.295], [40.445, 13.357], [40.489, 15.451], [40.445, 17.545], [48.259, 20.607], [47.518, 26.021], [39.168, 26.869], [38.647, 28.897], [38.042, 30.902], [0, 18.541], [0.148, 18.039], [0.27, 17.53], [0.366, 17.015], [0.434, 16.496], [0.475, 15.974], [0.489, 15.451], [0.475, 14.928], [0.434, 14.406], [0.366, 13.887], [0.27, 13.372], [0.148, 12.863], [0, 12.361]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
