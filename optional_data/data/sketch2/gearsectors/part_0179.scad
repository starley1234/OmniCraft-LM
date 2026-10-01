$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[40.986, 0], [42.21, 2.548], [43.313, 5.152], [51.86, 5.213], [53.647, 11.365], [46.463, 15.996], [46.927, 18.785], [47.26, 21.593], [55.451, 24.036], [55.451, 30.442], [47.26, 32.885], [46.927, 35.693], [46.463, 38.482], [53.647, 43.113], [51.86, 49.265], [43.313, 49.326], [42.21, 51.93], [40.986, 54.478], [0, 33.595], [0.316, 32.933], [0.596, 32.256], [0.841, 31.565], [1.049, 30.862], [1.22, 30.15], [1.354, 29.429], [1.449, 28.702], [1.507, 27.972], [1.526, 27.239], [1.507, 26.506], [1.449, 25.776], [1.354, 25.049], [1.22, 24.328], [1.049, 23.616], [0.841, 22.913], [0.596, 22.222], [0.316, 21.545], [0, 20.883]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
