$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 12;              // rack body height, Y
tooth_h = 5;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [72, 0], [72, 12], [70.2, 12], [68.1, 17], [63.9, 17], [61.8, 12], [58.2, 12], [56.1, 17], [51.9, 17], [49.8, 12], [46.2, 12], [44.1, 17], [39.9, 17], [37.8, 12], [34.2, 12], [32.1, 17], [27.9, 17], [25.8, 12], [22.2, 12], [20.1, 17], [15.9, 17], [13.8, 12], [10.2, 12], [8.1, 17], [3.9, 17], [1.8, 12], [0, 12]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
