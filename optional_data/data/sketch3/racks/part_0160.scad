$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 6;                // tooth pitch, X
root_w = 4.2;             // tooth width at the root
tip_w = 2.1;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [48, 0], [48, 10], [47.1, 10], [46.05, 14], [43.95, 14], [42.9, 10], [41.1, 10], [40.05, 14], [37.95, 14], [36.9, 10], [35.1, 10], [34.05, 14], [31.95, 14], [30.9, 10], [29.1, 10], [28.05, 14], [25.95, 14], [24.9, 10], [23.1, 10], [22.05, 14], [19.95, 14], [18.9, 10], [17.1, 10], [16.05, 14], [13.95, 14], [12.9, 10], [11.1, 10], [10.05, 14], [7.95, 14], [6.9, 10], [5.1, 10], [4.05, 14], [1.95, 14], [0.9, 10], [0, 10]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
