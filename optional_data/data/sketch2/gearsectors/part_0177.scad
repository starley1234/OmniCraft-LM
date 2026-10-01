$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[62.121, 0], [63.281, 2.743], [64.339, 5.528], [65.292, 8.349], [71.512, 11.976], [73.439, 22.475], [68.912, 28.073], [69.023, 31.05], [69.023, 34.028], [68.912, 37.005], [73.439, 42.603], [71.512, 53.102], [65.292, 56.729], [64.339, 59.55], [63.281, 62.335], [62.121, 65.078], [0, 37.42], [0.24, 36.839], [0.45, 36.247], [0.628, 35.645], [0.775, 35.034], [0.889, 34.416], [0.971, 33.793], [1.021, 33.167], [1.037, 32.539], [1.021, 31.911], [0.971, 31.285], [0.889, 30.662], [0.775, 30.044], [0.628, 29.433], [0.45, 28.831], [0.24, 28.239], [0, 27.658]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
