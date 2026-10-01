$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 14;              // rack body height, Y
tooth_h = 5;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [96, 0], [96, 14], [94.2, 14], [92.1, 19], [87.9, 19], [85.8, 14], [82.2, 14], [80.1, 19], [75.9, 19], [73.8, 14], [70.2, 14], [68.1, 19], [63.9, 19], [61.8, 14], [58.2, 14], [56.1, 19], [51.9, 19], [49.8, 14], [46.2, 14], [44.1, 19], [39.9, 19], [37.8, 14], [34.2, 14], [32.1, 19], [27.9, 19], [25.8, 14], [22.2, 14], [20.1, 19], [15.9, 19], [13.8, 14], [10.2, 14], [8.1, 19], [3.9, 19], [1.8, 14], [0, 14]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
