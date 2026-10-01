$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[45.65, 0], [46.377, 2.406], [47.002, 4.84], [54.465, 6.331], [55.322, 12.585], [48.534, 16.028], [48.587, 18.541], [48.534, 21.054], [55.322, 24.497], [54.465, 30.751], [47.002, 32.242], [46.377, 34.676], [45.65, 37.082], [0, 22.249], [0.178, 21.647], [0.325, 21.036], [0.439, 20.418], [0.521, 19.795], [0.571, 19.169], [0.587, 18.541], [0.571, 17.913], [0.521, 17.287], [0.439, 16.664], [0.325, 16.046], [0.178, 15.435], [0, 14.833]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
