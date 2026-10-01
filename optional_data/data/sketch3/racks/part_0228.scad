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
tooth_h = 4;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [60, 0], [60, 14], [59.1, 14], [58.05, 18], [55.95, 18], [54.9, 14], [53.1, 14], [52.05, 18], [49.95, 18], [48.9, 14], [47.1, 14], [46.05, 18], [43.95, 18], [42.9, 14], [41.1, 14], [40.05, 18], [37.95, 18], [36.9, 14], [35.1, 14], [34.05, 18], [31.95, 18], [30.9, 14], [29.1, 14], [28.05, 18], [25.95, 18], [24.9, 14], [23.1, 14], [22.05, 18], [19.95, 18], [18.9, 14], [17.1, 14], [16.05, 18], [13.95, 18], [12.9, 14], [11.1, 14], [10.05, 18], [7.95, 18], [6.9, 14], [5.1, 14], [4.05, 18], [1.95, 18], [0.9, 14], [0, 14]];  // primary outline, 44 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
