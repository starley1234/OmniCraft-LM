$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: sector, 32 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 30;        // sector angle, degrees
sector_r = 60;            // outer radius
arc_step = 1;             // sampling step of the arc, degrees
plate_t = 10;             // plate thickness, Z

bbox_x = 2 * sector_r * sin(sector_angle / 2);  // chord of the sector
bbox_y = sector_r;  // depth of the sector (apex to arc)

profile = [[57.956, 0], [58.218, 1.014], [58.462, 2.032], [58.689, 3.054], [58.898, 4.08], [59.088, 5.11], [59.261, 6.143], [59.416, 7.179], [59.553, 8.217], [59.671, 9.257], [59.772, 10.3], [59.854, 11.344], [59.918, 12.389], [59.963, 13.435], [59.991, 14.482], [60, 15.529], [59.991, 16.576], [59.963, 17.623], [59.918, 18.669], [59.854, 19.714], [59.772, 20.758], [59.671, 21.801], [59.553, 22.841], [59.416, 23.879], [59.261, 24.915], [59.088, 25.948], [58.898, 26.978], [58.689, 28.004], [58.462, 29.026], [58.218, 30.044], [57.956, 31.058], [0, 15.529]];  // primary outline, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
