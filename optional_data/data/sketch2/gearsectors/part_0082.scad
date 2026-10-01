$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[47.552, 0], [48.107, 1.802], [48.604, 3.62], [54.9, 4.144], [55.676, 8.216], [50.016, 11.021], [50.223, 12.895], [50.371, 14.774], [56.456, 16.468], [56.456, 20.614], [50.371, 22.308], [50.223, 24.187], [50.016, 26.061], [55.676, 28.866], [54.9, 32.938], [48.604, 33.462], [48.107, 35.28], [47.552, 37.082], [0, 21.631], [0.148, 21.129], [0.27, 20.62], [0.366, 20.105], [0.434, 19.586], [0.475, 19.064], [0.489, 18.541], [0.475, 18.018], [0.434, 17.496], [0.366, 16.977], [0.27, 16.462], [0.148, 15.953], [0, 15.451]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
