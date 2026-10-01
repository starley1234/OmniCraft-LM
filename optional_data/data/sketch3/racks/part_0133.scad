$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 12 teeth, pitch 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 12;               // number of teeth
pitch = 8;                // tooth pitch, X
root_w = 5.6;             // tooth width at the root
tip_w = 2.8;              // tooth width at the tip
base_h = 12;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [96, 0], [96, 12], [94.8, 12], [93.4, 16], [90.6, 16], [89.2, 12], [86.8, 12], [85.4, 16], [82.6, 16], [81.2, 12], [78.8, 12], [77.4, 16], [74.6, 16], [73.2, 12], [70.8, 12], [69.4, 16], [66.6, 16], [65.2, 12], [62.8, 12], [61.4, 16], [58.6, 16], [57.2, 12], [54.8, 12], [53.4, 16], [50.6, 16], [49.2, 12], [46.8, 12], [45.4, 16], [42.6, 16], [41.2, 12], [38.8, 12], [37.4, 16], [34.6, 16], [33.2, 12], [30.8, 12], [29.4, 16], [26.6, 16], [25.2, 12], [22.8, 12], [21.4, 16], [18.6, 16], [17.2, 12], [14.8, 12], [13.4, 16], [10.6, 16], [9.2, 12], [6.8, 12], [5.4, 16], [2.6, 16], [1.2, 12], [0, 12]];  // primary outline, 52 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
