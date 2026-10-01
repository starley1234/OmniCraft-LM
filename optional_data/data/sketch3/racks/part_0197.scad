$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 10 teeth, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 10;               // number of teeth
pitch = 10;               // tooth pitch, X
root_w = 7;               // tooth width at the root
tip_w = 3.5;              // tooth width at the tip
base_h = 14;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [100, 0], [100, 14], [98.5, 14], [96.75, 18], [93.25, 18], [91.5, 14], [88.5, 14], [86.75, 18], [83.25, 18], [81.5, 14], [78.5, 14], [76.75, 18], [73.25, 18], [71.5, 14], [68.5, 14], [66.75, 18], [63.25, 18], [61.5, 14], [58.5, 14], [56.75, 18], [53.25, 18], [51.5, 14], [48.5, 14], [46.75, 18], [43.25, 18], [41.5, 14], [38.5, 14], [36.75, 18], [33.25, 18], [31.5, 14], [28.5, 14], [26.75, 18], [23.25, 18], [21.5, 14], [18.5, 14], [16.75, 18], [13.25, 18], [11.5, 14], [8.5, 14], [6.75, 18], [3.25, 18], [1.5, 14], [0, 14]];  // primary outline, 44 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
