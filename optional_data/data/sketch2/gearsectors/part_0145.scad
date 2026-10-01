$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[40.986, 0], [42.08, 2.262], [43.078, 4.569], [43.979, 6.915], [50.086, 9.595], [51.947, 18.586], [47.408, 23.472], [47.513, 25.982], [47.513, 28.496], [47.408, 31.006], [51.947, 35.892], [50.086, 44.883], [43.979, 47.563], [43.078, 49.909], [42.08, 52.216], [40.986, 54.478], [0, 33.595], [0.316, 32.933], [0.596, 32.256], [0.841, 31.565], [1.049, 30.862], [1.22, 30.15], [1.354, 29.429], [1.449, 28.702], [1.507, 27.972], [1.526, 27.239], [1.507, 26.506], [1.449, 25.776], [1.354, 25.049], [1.22, 24.328], [1.049, 23.616], [0.841, 22.913], [0.596, 22.222], [0.316, 21.545], [0, 20.883]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
