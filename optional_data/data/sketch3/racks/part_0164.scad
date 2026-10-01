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
tooth_h = 6;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [144, 0], [144, 10], [142.2, 10], [140.1, 16], [135.9, 16], [133.8, 10], [130.2, 10], [128.1, 16], [123.9, 16], [121.8, 10], [118.2, 10], [116.1, 16], [111.9, 16], [109.8, 10], [106.2, 10], [104.1, 16], [99.9, 16], [97.8, 10], [94.2, 10], [92.1, 16], [87.9, 16], [85.8, 10], [82.2, 10], [80.1, 16], [75.9, 16], [73.8, 10], [70.2, 10], [68.1, 16], [63.9, 16], [61.8, 10], [58.2, 10], [56.1, 16], [51.9, 16], [49.8, 10], [46.2, 10], [44.1, 16], [39.9, 16], [37.8, 10], [34.2, 10], [32.1, 16], [27.9, 16], [25.8, 10], [22.2, 10], [20.1, 16], [15.9, 16], [13.8, 10], [10.2, 10], [8.1, 16], [3.9, 16], [1.8, 10], [0, 10]];  // primary outline, 52 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
