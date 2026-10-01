$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[63.483, 0], [64.795, 3.682], [65.925, 7.425], [71.862, 10.634], [73.339, 19.858], [68.701, 24.761], [68.797, 28.669], [68.701, 32.577], [73.339, 37.48], [71.862, 46.704], [65.925, 49.913], [64.795, 53.656], [63.483, 57.338], [0, 32.969], [0.21, 32.377], [0.388, 31.775], [0.535, 31.164], [0.649, 30.546], [0.731, 29.923], [0.781, 29.297], [0.797, 28.669], [0.781, 28.041], [0.731, 27.415], [0.649, 26.792], [0.535, 26.174], [0.388, 25.563], [0.21, 24.961], [0, 24.369]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
