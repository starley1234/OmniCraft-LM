$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: sector, 38 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
sector_r = 80;            // outer radius
arc_step = 1;             // sampling step of the arc, degrees
plate_t = 8;              // plate thickness, Z
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 2 * sector_r * sin(sector_angle / 2);  // chord of the sector
bbox_y = sector_r;  // depth of the sector (apex to arc)

profile = [[76.085, 0], [76.504, 1.331], [76.901, 2.67], [77.274, 4.015], [77.624, 5.367], [77.95, 6.725], [78.252, 8.088], [78.53, 9.456], [78.785, 10.829], [79.015, 12.206], [79.221, 13.587], [79.404, 14.971], [79.562, 16.359], [79.696, 17.749], [79.805, 19.14], [79.89, 20.534], [79.951, 21.929], [79.988, 23.325], [80, 24.721], [79.988, 26.117], [79.951, 27.513], [79.89, 28.908], [79.805, 30.302], [79.696, 31.693], [79.562, 33.083], [79.404, 34.471], [79.221, 35.855], [79.015, 37.236], [78.785, 38.613], [78.53, 39.986], [78.252, 41.354], [77.95, 42.717], [77.624, 44.075], [77.274, 45.427], [76.901, 46.772], [76.504, 48.111], [76.085, 49.442], [0, 24.721]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
