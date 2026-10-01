$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 12;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [96, 0], [96, 12], [94.2, 12], [92.1, 15], [87.9, 15], [85.8, 12], [82.2, 12], [80.1, 15], [75.9, 15], [73.8, 12], [70.2, 12], [68.1, 15], [63.9, 15], [61.8, 12], [58.2, 12], [56.1, 15], [51.9, 15], [49.8, 12], [46.2, 12], [44.1, 15], [39.9, 15], [37.8, 12], [34.2, 12], [32.1, 15], [27.9, 15], [25.8, 12], [22.2, 12], [20.1, 15], [15.9, 15], [13.8, 12], [10.2, 12], [8.1, 15], [3.9, 15], [1.8, 12], [0, 12]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
