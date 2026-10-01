$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 14;              // rack body height, Y
tooth_h = 6;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [72, 0], [72, 14], [70.2, 14], [68.1, 20], [63.9, 20], [61.8, 14], [58.2, 14], [56.1, 20], [51.9, 20], [49.8, 14], [46.2, 14], [44.1, 20], [39.9, 20], [37.8, 14], [34.2, 14], [32.1, 20], [27.9, 20], [25.8, 14], [22.2, 14], [20.1, 20], [15.9, 20], [13.8, 14], [10.2, 14], [8.1, 20], [3.9, 20], [1.8, 14], [0, 14]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
