$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 10;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [72, 0], [72, 10], [70.2, 10], [68.1, 14], [63.9, 14], [61.8, 10], [58.2, 10], [56.1, 14], [51.9, 14], [49.8, 10], [46.2, 10], [44.1, 14], [39.9, 14], [37.8, 10], [34.2, 10], [32.1, 14], [27.9, 14], [25.8, 10], [22.2, 10], [20.1, 14], [15.9, 14], [13.8, 10], [10.2, 10], [8.1, 14], [3.9, 14], [1.8, 10], [0, 10]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
