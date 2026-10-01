$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[47.552, 0], [48.412, 2.891], [56.535, 2.355], [57.224, 5.484], [49.628, 8.411], [50.062, 11.395], [58.177, 12.035], [58.408, 15.231], [50.47, 17.033], [50.47, 20.049], [58.408, 21.851], [58.177, 25.047], [50.062, 25.687], [49.628, 28.671], [57.224, 31.598], [56.535, 34.727], [48.412, 34.191], [47.552, 37.082], [0, 21.631], [0.148, 21.129], [0.27, 20.62], [0.366, 20.105], [0.434, 19.586], [0.475, 19.064], [0.489, 18.541], [0.475, 18.018], [0.434, 17.496], [0.366, 16.977], [0.27, 16.462], [0.148, 15.953], [0, 15.451]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
