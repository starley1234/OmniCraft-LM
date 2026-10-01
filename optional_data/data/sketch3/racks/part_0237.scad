$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 10 teeth, pitch 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 10;               // number of teeth
pitch = 6;                // tooth pitch, X
root_w = 4.2;             // tooth width at the root
tip_w = 2.1;              // tooth width at the tip
base_h = 14;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [60, 0], [60, 14], [59.1, 14], [58.05, 17], [55.95, 17], [54.9, 14], [53.1, 14], [52.05, 17], [49.95, 17], [48.9, 14], [47.1, 14], [46.05, 17], [43.95, 17], [42.9, 14], [41.1, 14], [40.05, 17], [37.95, 17], [36.9, 14], [35.1, 14], [34.05, 17], [31.95, 17], [30.9, 14], [29.1, 14], [28.05, 17], [25.95, 17], [24.9, 14], [23.1, 14], [22.05, 17], [19.95, 17], [18.9, 14], [17.1, 14], [16.05, 17], [13.95, 17], [12.9, 14], [11.1, 14], [10.05, 17], [7.95, 17], [6.9, 14], [5.1, 14], [4.05, 17], [1.95, 17], [0.9, 14], [0, 14]];  // primary outline, 44 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
