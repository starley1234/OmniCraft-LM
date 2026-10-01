$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 8;                // tooth pitch, X
root_w = 5.6;             // tooth width at the root
tip_w = 2.8;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [64, 0], [64, 10], [62.8, 10], [61.4, 13], [58.6, 13], [57.2, 10], [54.8, 10], [53.4, 13], [50.6, 13], [49.2, 10], [46.8, 10], [45.4, 13], [42.6, 13], [41.2, 10], [38.8, 10], [37.4, 13], [34.6, 13], [33.2, 10], [30.8, 10], [29.4, 13], [26.6, 13], [25.2, 10], [22.8, 10], [21.4, 13], [18.6, 13], [17.2, 10], [14.8, 10], [13.4, 13], [10.6, 13], [9.2, 10], [6.8, 10], [5.4, 13], [2.6, 13], [1.2, 10], [0, 10]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
