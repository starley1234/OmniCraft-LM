$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 10;               // tooth pitch, X
root_w = 7;               // tooth width at the root
tip_w = 3.5;              // tooth width at the tip
base_h = 14;              // rack body height, Y
tooth_h = 5;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [80, 0], [80, 14], [78.5, 14], [76.75, 19], [73.25, 19], [71.5, 14], [68.5, 14], [66.75, 19], [63.25, 19], [61.5, 14], [58.5, 14], [56.75, 19], [53.25, 19], [51.5, 14], [48.5, 14], [46.75, 19], [43.25, 19], [41.5, 14], [38.5, 14], [36.75, 19], [33.25, 19], [31.5, 14], [28.5, 14], [26.75, 19], [23.25, 19], [21.5, 14], [18.5, 14], [16.75, 19], [13.25, 19], [11.5, 14], [8.5, 14], [6.75, 19], [3.25, 19], [1.5, 14], [0, 14]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
