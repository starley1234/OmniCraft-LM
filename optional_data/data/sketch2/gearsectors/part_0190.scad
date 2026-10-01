$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[47.552, 0], [48.412, 2.891], [54.592, 2.831], [55.261, 5.868], [49.628, 8.411], [50.062, 11.395], [56.186, 12.227], [56.411, 15.328], [50.47, 17.033], [50.47, 20.049], [56.411, 21.754], [56.186, 24.855], [50.062, 25.687], [49.628, 28.671], [55.261, 31.214], [54.592, 34.251], [48.412, 34.191], [47.552, 37.082], [0, 21.631], [0.148, 21.129], [0.27, 20.62], [0.366, 20.105], [0.434, 19.586], [0.475, 19.064], [0.489, 18.541], [0.475, 18.018], [0.434, 17.496], [0.366, 16.977], [0.27, 16.462], [0.148, 15.953], [0, 15.451]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
