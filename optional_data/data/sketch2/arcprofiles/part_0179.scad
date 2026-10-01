$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: sector, 32 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 30;        // sector angle, degrees
sector_r = 80;            // outer radius
arc_step = 1;             // sampling step of the arc, degrees
plate_t = 10;             // plate thickness, Z

bbox_x = 2 * sector_r * sin(sector_angle / 2);  // chord of the sector
bbox_y = sector_r;  // depth of the sector (apex to arc)

profile = [[77.274, 0], [77.624, 1.352], [77.95, 2.71], [78.252, 4.073], [78.53, 5.441], [78.785, 6.814], [79.015, 8.191], [79.221, 9.572], [79.404, 10.956], [79.562, 12.344], [79.696, 13.734], [79.805, 15.125], [79.89, 16.519], [79.951, 17.914], [79.988, 19.31], [80, 20.706], [79.988, 22.102], [79.951, 23.498], [79.89, 24.893], [79.805, 26.287], [79.696, 27.678], [79.562, 29.068], [79.404, 30.456], [79.221, 31.84], [79.015, 33.221], [78.785, 34.598], [78.53, 35.971], [78.252, 37.339], [77.95, 38.702], [77.624, 40.06], [77.274, 41.412], [0, 20.706]];  // primary outline, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
