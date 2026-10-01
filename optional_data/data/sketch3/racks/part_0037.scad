$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [96, 0], [96, 10], [94.2, 10], [92.1, 13], [87.9, 13], [85.8, 10], [82.2, 10], [80.1, 13], [75.9, 13], [73.8, 10], [70.2, 10], [68.1, 13], [63.9, 13], [61.8, 10], [58.2, 10], [56.1, 13], [51.9, 13], [49.8, 10], [46.2, 10], [44.1, 13], [39.9, 13], [37.8, 10], [34.2, 10], [32.1, 13], [27.9, 13], [25.8, 10], [22.2, 10], [20.1, 13], [15.9, 13], [13.8, 10], [10.2, 10], [8.1, 13], [3.9, 13], [1.8, 10], [0, 10]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
