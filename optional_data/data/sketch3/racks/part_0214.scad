$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 8;                // tooth pitch, X
root_w = 5.6;             // tooth width at the root
tip_w = 2.8;              // tooth width at the tip
base_h = 14;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [64, 0], [64, 14], [62.8, 14], [61.4, 17], [58.6, 17], [57.2, 14], [54.8, 14], [53.4, 17], [50.6, 17], [49.2, 14], [46.8, 14], [45.4, 17], [42.6, 17], [41.2, 14], [38.8, 14], [37.4, 17], [34.6, 17], [33.2, 14], [30.8, 14], [29.4, 17], [26.6, 17], [25.2, 14], [22.8, 14], [21.4, 17], [18.6, 17], [17.2, 14], [14.8, 14], [13.4, 17], [10.6, 17], [9.2, 14], [6.8, 14], [5.4, 17], [2.6, 17], [1.2, 14], [0, 14]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
