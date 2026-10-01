$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 12 teeth, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 12;               // number of teeth
pitch = 10;               // tooth pitch, X
root_w = 7;               // tooth width at the root
tip_w = 3.5;              // tooth width at the tip
base_h = 14;              // rack body height, Y
tooth_h = 6;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [120, 0], [120, 14], [118.5, 14], [116.75, 20], [113.25, 20], [111.5, 14], [108.5, 14], [106.75, 20], [103.25, 20], [101.5, 14], [98.5, 14], [96.75, 20], [93.25, 20], [91.5, 14], [88.5, 14], [86.75, 20], [83.25, 20], [81.5, 14], [78.5, 14], [76.75, 20], [73.25, 20], [71.5, 14], [68.5, 14], [66.75, 20], [63.25, 20], [61.5, 14], [58.5, 14], [56.75, 20], [53.25, 20], [51.5, 14], [48.5, 14], [46.75, 20], [43.25, 20], [41.5, 14], [38.5, 14], [36.75, 20], [33.25, 20], [31.5, 14], [28.5, 14], [26.75, 20], [23.25, 20], [21.5, 14], [18.5, 14], [16.75, 20], [13.25, 20], [11.5, 14], [8.5, 14], [6.75, 20], [3.25, 20], [1.5, 14], [0, 14]];  // primary outline, 52 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
