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
tooth_h = 3;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [120, 0], [120, 14], [118.5, 14], [116.75, 17], [113.25, 17], [111.5, 14], [108.5, 14], [106.75, 17], [103.25, 17], [101.5, 14], [98.5, 14], [96.75, 17], [93.25, 17], [91.5, 14], [88.5, 14], [86.75, 17], [83.25, 17], [81.5, 14], [78.5, 14], [76.75, 17], [73.25, 17], [71.5, 14], [68.5, 14], [66.75, 17], [63.25, 17], [61.5, 14], [58.5, 14], [56.75, 17], [53.25, 17], [51.5, 14], [48.5, 14], [46.75, 17], [43.25, 17], [41.5, 14], [38.5, 14], [36.75, 17], [33.25, 17], [31.5, 14], [28.5, 14], [26.75, 17], [23.25, 17], [21.5, 14], [18.5, 14], [16.75, 17], [13.25, 17], [11.5, 14], [8.5, 14], [6.75, 17], [3.25, 17], [1.5, 14], [0, 14]];  // primary outline, 52 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
