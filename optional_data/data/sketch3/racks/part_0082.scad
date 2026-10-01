$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 12 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 12;               // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 10;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [144, 0], [144, 10], [142.2, 10], [140.1, 14], [135.9, 14], [133.8, 10], [130.2, 10], [128.1, 14], [123.9, 14], [121.8, 10], [118.2, 10], [116.1, 14], [111.9, 14], [109.8, 10], [106.2, 10], [104.1, 14], [99.9, 14], [97.8, 10], [94.2, 10], [92.1, 14], [87.9, 14], [85.8, 10], [82.2, 10], [80.1, 14], [75.9, 14], [73.8, 10], [70.2, 10], [68.1, 14], [63.9, 14], [61.8, 10], [58.2, 10], [56.1, 14], [51.9, 14], [49.8, 10], [46.2, 10], [44.1, 14], [39.9, 14], [37.8, 10], [34.2, 10], [32.1, 14], [27.9, 14], [25.8, 10], [22.2, 10], [20.1, 14], [15.9, 14], [13.8, 10], [10.2, 10], [8.1, 14], [3.9, 14], [1.8, 10], [0, 10]];  // primary outline, 52 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
