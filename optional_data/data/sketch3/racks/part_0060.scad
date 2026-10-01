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
tooth_h = 4;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [72, 0], [72, 14], [70.2, 14], [68.1, 18], [63.9, 18], [61.8, 14], [58.2, 14], [56.1, 18], [51.9, 18], [49.8, 14], [46.2, 14], [44.1, 18], [39.9, 18], [37.8, 14], [34.2, 14], [32.1, 18], [27.9, 18], [25.8, 14], [22.2, 14], [20.1, 18], [15.9, 18], [13.8, 14], [10.2, 14], [8.1, 18], [3.9, 18], [1.8, 14], [0, 14]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
