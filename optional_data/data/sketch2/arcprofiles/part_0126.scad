$fn = 32;

// ----------------------------------------------------------------------
// Arc profile plate: sector, 32 points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 30;        // sector angle, degrees
sector_r = 70;            // outer radius
arc_step = 1;             // sampling step of the arc, degrees
plate_t = 8;              // plate thickness, Z

bbox_x = 2 * sector_r * sin(sector_angle / 2);  // chord of the sector
bbox_y = sector_r;  // depth of the sector (apex to arc)

profile = [[67.615, 0], [67.921, 1.182], [68.206, 2.37], [68.47, 3.563], [68.714, 4.76], [68.937, 5.962], [69.138, 7.167], [69.319, 8.375], [69.478, 9.586], [69.617, 10.8], [69.734, 12.016], [69.829, 13.234], [69.904, 14.453], [69.957, 15.674], [69.989, 16.895], [70, 18.117], [69.989, 19.339], [69.957, 20.56], [69.904, 21.781], [69.829, 23], [69.734, 24.218], [69.617, 25.434], [69.478, 26.648], [69.319, 27.859], [69.138, 29.067], [68.937, 30.272], [68.714, 31.474], [68.47, 32.671], [68.206, 33.864], [67.921, 35.052], [67.615, 36.234], [0, 18.117]];  // primary outline, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
