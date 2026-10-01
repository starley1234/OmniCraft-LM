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
tooth_h = 4;              // tooth height above the body
plate_t = 10;             // rack width, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [64, 0], [64, 14], [62.8, 14], [61.4, 18], [58.6, 18], [57.2, 14], [54.8, 14], [53.4, 18], [50.6, 18], [49.2, 14], [46.8, 14], [45.4, 18], [42.6, 18], [41.2, 14], [38.8, 14], [37.4, 18], [34.6, 18], [33.2, 14], [30.8, 14], [29.4, 18], [26.6, 18], [25.2, 14], [22.8, 14], [21.4, 18], [18.6, 18], [17.2, 14], [14.8, 14], [13.4, 18], [10.6, 18], [9.2, 14], [6.8, 14], [5.4, 18], [2.6, 18], [1.2, 14], [0, 14]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
