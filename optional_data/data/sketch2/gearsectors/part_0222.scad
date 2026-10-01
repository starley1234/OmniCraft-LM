$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[47.552, 0], [48.279, 2.406], [48.904, 4.84], [57.35, 6.149], [58.22, 12.496], [50.436, 16.028], [50.489, 18.541], [50.436, 21.054], [58.22, 24.586], [57.35, 30.933], [48.904, 32.242], [48.279, 34.676], [47.552, 37.082], [0, 21.631], [0.148, 21.129], [0.27, 20.62], [0.366, 20.105], [0.434, 19.586], [0.475, 19.064], [0.489, 18.541], [0.475, 18.018], [0.434, 17.496], [0.366, 16.977], [0.27, 16.462], [0.148, 15.953], [0, 15.451]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
