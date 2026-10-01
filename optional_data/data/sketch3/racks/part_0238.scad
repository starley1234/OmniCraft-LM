$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 12 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 12;               // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 12;              // rack body height, Y
tooth_h = 6;              // tooth height above the body
plate_t = 10;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [144, 0], [144, 12], [142.2, 12], [140.1, 18], [135.9, 18], [133.8, 12], [130.2, 12], [128.1, 18], [123.9, 18], [121.8, 12], [118.2, 12], [116.1, 18], [111.9, 18], [109.8, 12], [106.2, 12], [104.1, 18], [99.9, 18], [97.8, 12], [94.2, 12], [92.1, 18], [87.9, 18], [85.8, 12], [82.2, 12], [80.1, 18], [75.9, 18], [73.8, 12], [70.2, 12], [68.1, 18], [63.9, 18], [61.8, 12], [58.2, 12], [56.1, 18], [51.9, 18], [49.8, 12], [46.2, 12], [44.1, 18], [39.9, 18], [37.8, 12], [34.2, 12], [32.1, 18], [27.9, 18], [25.8, 12], [22.2, 12], [20.1, 18], [15.9, 18], [13.8, 12], [10.2, 12], [8.1, 18], [3.9, 18], [1.8, 12], [0, 12]];  // primary outline, 52 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
