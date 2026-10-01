$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[54.148, 0], [55.295, 3.223], [56.284, 6.497], [63.067, 8.96], [64.388, 17.208], [58.713, 21.667], [58.797, 25.086], [58.713, 28.505], [64.388, 32.964], [63.067, 41.212], [56.284, 43.675], [55.295, 46.949], [54.148, 50.172], [0, 29.386], [0.21, 28.794], [0.388, 28.192], [0.535, 27.581], [0.649, 26.963], [0.731, 26.34], [0.781, 25.714], [0.797, 25.086], [0.781, 24.458], [0.731, 23.832], [0.649, 23.209], [0.535, 22.591], [0.388, 21.98], [0.21, 21.378], [0, 20.786]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
