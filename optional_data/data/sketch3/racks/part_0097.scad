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
tooth_h = 3;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [96, 0], [96, 14], [94.2, 14], [92.1, 17], [87.9, 17], [85.8, 14], [82.2, 14], [80.1, 17], [75.9, 17], [73.8, 14], [70.2, 14], [68.1, 17], [63.9, 17], [61.8, 14], [58.2, 14], [56.1, 17], [51.9, 17], [49.8, 14], [46.2, 14], [44.1, 17], [39.9, 17], [37.8, 14], [34.2, 14], [32.1, 17], [27.9, 17], [25.8, 14], [22.2, 14], [20.1, 17], [15.9, 17], [13.8, 14], [10.2, 14], [8.1, 17], [3.9, 17], [1.8, 14], [0, 14]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
